import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/BlockUserModel.dart';
import 'package:Okuna/matchmaking/model/ChannelParticipation.dart';
import 'package:Okuna/matchmaking/model/ChatModel.dart';
import 'package:Okuna/matchmaking/model/ChatVideoContainer.dart';
import 'package:Okuna/matchmaking/model/ConversationModel.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/model/MessageData.dart';
import 'package:Okuna/matchmaking/model/Swipe.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/SwipeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dating/main.dart';
// import 'package:dating/services/helper.dart';
// import 'package:dating/ui/matchScreen/MatchScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FireStoreUtils {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();
  List<Swipe> matchedUsersList = [];
  StreamController<List<HomeConversationModel>> conversationsStream;
  List<HomeConversationModel> homeConversations = [];
  List<BlockUserModel> blockedList = [];
  List<User> matches = [];
  StreamController<List<User>> tinderCardsStreamController;


  static Future<User> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument.exists) {
      return User.fromJson(userDocument.data() ?? {});
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    }, onError: (e) {
      return null;
    });
  }

  Future<bool> blockUser(User blockedUser, String type) async {
    bool isSuccessful = false;
    BlockUserModel blockUserModel = BlockUserModel(
        type: type,
        source: SwipeScreenState.currentUser.userID,
        dest: blockedUser.userID,
        createdAt: Timestamp.now());
    await firestore
        .collection(REPORTS)
        .add(blockUserModel.toJson())
        .then((onValue) {
      isSuccessful = true;
    });
    return isSuccessful;
  }


  /// login with email and password with firebase
  /// @param email user email
  /// @param password user password
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password ) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot documentSnapshot =
          await firestore.collection(USERS).doc(result.user?.uid ?? '').get();
      User user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
        user.fcmToken = await firebaseMessaging.getToken() ?? '';
        await updateCurrentUser(user);
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
      switch ((exception).code) {
        case "invalid-email":
          return 'Email address is malformed.';
        case "wrong-password":
          return 'Wrong password.';
        case "user-not-found":
          return 'No user corresponding to the given email address.';
        case "user-disabled":
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      print(e.toString() + '$s');
      return 'Login failed, Please try again.';
    }
  }


  Stream<List<User>> getTinderUsers() async* {
    tinderCardsStreamController = StreamController<List<User>>();
    List<User> tinderUsers = [];
    print('GETTINSUEDSE');
      await firestore
          .collection(USERS)
          .where('showMe', isEqualTo: true)
          .get()
          .then((value) async {
        value.docs.forEach((DocumentSnapshot tinderUser) async {
          print('Heretpp');
          print(SwipeScreenState.currentUser);
          try {
            if (tinderUser.id != SwipeScreenState.currentUser.userID) {
              User user = User.fromJson(tinderUser.data() ?? {});
              if (await _isValidUserForTinderSwipe(user)) {
                tinderUsers.insert(0, user);
                tinderCardsStreamController.add(tinderUsers);
              }
              if (tinderUsers.isEmpty) {
                tinderCardsStreamController.add(tinderUsers);
              }
            }
          } catch (e) {
            print(
                'FireStoreUtils.getTinderUsers failed to parse user object $e');
          }
        });
      }, onError: (e) {
        print('${(e as PlatformException).message}');
      });
    yield* tinderCardsStreamController.stream;
  }


  Future<bool> _isValidUserForTinderSwipe(User tinderUser) async {
    //make sure that we haven't swiped right this user before
    QuerySnapshot result1 = await firestore
        .collection(SWIPES)
        .where('user1', isEqualTo: SwipeScreenState.currentUser.userID)
        .where('user2', isEqualTo: tinderUser.userID)
        .get()
        .catchError((onError) {
      print('${(onError as PlatformException).message}');
    });
    return result1.docs.isEmpty;
  }


  Future<User> onSwipeRight(User user) async {
    // check if this user sent a match request before ? if yes, it's a match,
    // if not, send him match request
    QuerySnapshot querySnapshot = await firestore
        .collection(SWIPES)
        .where('user1', isEqualTo: user.userID)
        .where('user2', isEqualTo: SwipeScreenState.currentUser.userID)
        .where('type', isEqualTo: 'like')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      //this user sent me a match request, let's talk
      DocumentReference document = firestore.collection(SWIPES).doc();
      var swipe = Swipe(
          id: document.id,
          type: 'like',
          hasBeenSeen: true,
          createdAt: Timestamp.now(),
          user1: SwipeScreenState.currentUser.userID,
          user2: user.userID);
      await document.set(swipe.toJson());
      if (user.settings.pushNewMatchesEnabled) {
        await sendNotification(
            user.fcmToken,
            'New match',
            'You have got a new '
                'match: ${SwipeScreenState.currentUser.fullName()}.',
            null);
      }

      return user;
    } else {
      //this user didn't send me a match request, let's send match request
      // and keep swiping
      await sendSwipeRequest(user, SwipeScreenState.currentUser.userID);
      return null;
    }
  }

  Future<bool> sendSwipeRequest(User user, String myID) async {
    bool isSuccessful = false;
    DocumentReference documentReference = firestore.collection(SWIPES).doc();
    Swipe swipe = Swipe(
        id: documentReference.id,
        user1: myID,
        user2: user.userID,
        hasBeenSeen: false,
        createdAt: Timestamp.now(),
        type: 'like');
    await documentReference.set(swipe.toJson()).then((onValue) {
      isSuccessful = true;
    }, onError: (e) {
      isSuccessful = false;
    });
    return isSuccessful;
  }


  onSwipeLeft(User dislikedUser) async {
    DocumentReference documentReference =
    firestore.collection(SWIPES).doc();
    Swipe leftSwipe = Swipe(
        id: documentReference.id,
        type: 'dislike',
        user1: SwipeScreenState.currentUser.userID,
        user2: dislikedUser.userID,
        createdAt: Timestamp.now(),
        hasBeenSeen: false);
    await documentReference.set(leftSwipe.toJson());
  }

  undo(User tinderUser) async {
    await firestore
        .collection(SWIPES)
        .where('user1', isEqualTo: SwipeScreenState.currentUser.userID)
        .where('user2', isEqualTo: tinderUser.userID)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        await firestore
            .collection(SWIPES)
            .doc(value.docs.first.id)
            .delete();
      }
    });
  }
  void updateCardStream(List<User> data) {
    tinderCardsStreamController.add(data);
  }

  sendNotification(String token, String title, String body,
      Map<String, dynamic> payload) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$SERVER_KEY',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': payload ?? <String, dynamic>{},
          'to': token
        },
      ),
    );
  }
}


