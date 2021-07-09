import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/ConversationsScreen.dart';
import 'package:Okuna/matchmaking/pages/ProfileScreen.dart';
import 'package:Okuna/matchmaking/pages/SwipeScreen.dart';
import 'package:Okuna/matchmaking/pages/videoCall/VideoCallScreen.dart';
import 'package:Okuna/matchmaking/pages/voiceCall/VoiceCallScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/pages/home/lib/poppable_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static bool onGoingCall = false;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String _appBarTitle = 'Swipe';
  Widget _currentWidget;


  static User currentUser;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;

  Future<void> getCurrentUser() async{
    final auth.User user = auth.FirebaseAuth.instance.currentUser;
    currentUser = await FireStoreUtils.getCurrentUser(user.uid);
    setState(() {
      _initialized = true;
      _currentWidget = SwipeScreen(
        user: currentUser,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if(_initialized){
      return ChangeNotifierProvider.value(
        value: currentUser,
        child: Consumer<User>(
          builder: (context, user, _) {
            return Scaffold(
              appBar: AppBar(
                title: GestureDetector(
                  onTap: () {
                    setState(() {
                      _appBarTitle = 'Swipe';
                      _currentWidget = SwipeScreen(
                          user: currentUser,
                        );
                    });
                  },
                  child: Image.asset(
                    'assets/images/icon-adaptive-foreground.png',
                    width: _appBarTitle == 'Swipe' ? 60 : 45,
                    height: _appBarTitle == 'Swipe' ? 60 : 45,
                    color: _appBarTitle == 'Swipe'
                            ? Color(COLOR_PRIMARY)
                            : Colors.grey,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _appBarTitle == 'Profile'
                            ? Color(COLOR_PRIMARY)
                            : Colors.grey,
                  ),
                  iconSize: _appBarTitle == 'Profile' ? 35 : 24,
                  onPressed: () {
                    setState(() {
                      _appBarTitle = 'Profile';
                      _currentWidget = ProfileScreen(user: currentUser);
                    });
                  }
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      setState(() {
                        _appBarTitle = 'Conversations';
                        _currentWidget = ConversationsScreen(user: currentUser);
                      });
                    },
                    color: _appBarTitle == 'Conversations'
                          ? Color(COLOR_PRIMARY)
                          : Colors.grey,
                    iconSize: _appBarTitle == 'Conversations' ? 35 : 24,
                  )
                ],  
                backgroundColor: Colors.transparent,
                brightness: Brightness.light,
                centerTitle: true,
                elevation: 0,      
              ),
              body: _currentWidget,
            );
          },
        ),
      );      
    }

    return Container();
    
    }
  void _listenForCalls() {
    Stream<QuerySnapshot> callStream = FireStoreUtils.firestore
        .collection(USERS)
        .doc(currentUser.userID)
        .collection(CALL_DATA)
        .snapshots();
    // ignore: cancel_subscriptions
    final callSubscription = callStream.listen((event) async {
      if (event.docs.isNotEmpty) {
        DocumentSnapshot callDocument = event.docs.first;
        if (callDocument.id != currentUser.userID) {
          DocumentSnapshot userSnapShot = await FireStoreUtils.firestore
              .collection(USERS)
              .doc(event.docs.first.id)
              .get();

          User caller = User.fromJson(userSnapShot.data() ?? {});
          print('${caller.fullName()} called you');
          print('${callDocument.data()['type'] ?? 'null'}');
          String type = callDocument.data()['type'] ?? '';
          String callType = callDocument.data()['callType'] ?? '';
          if (type == 'offer') {
            if (callType == VIDEO) {
                push(
                  context,
                  VideoCallScreen(
                      homeConversationModel: HomeConversationModel(
                          isGroupChat: false,
                          conversationModel: null,
                          members: [caller]),
                      isCaller: false,
                      sessionDescription: callDocument.data()['data']
                          ['description']['sdp'],
                      sessionType: callDocument.data()['data']['description']
                          ['type']),
                );
              
            } else if (callType == VOICE) {
              
                push(
                  context,
                  VoiceCallScreen(
                      homeConversationModel: HomeConversationModel(
                          isGroupChat: false,
                          conversationModel: null,
                          members: [caller]),
                      isCaller: false,
                      sessionDescription: callDocument.data()['data']
                          ['description']['sdp'],
                      sessionType: callDocument.data()['data']['description']
                          ['type']),
                );
            }
          }
        } else {
          print('you called someone');
        }
      }
    });
    auth.FirebaseAuth.instance.authStateChanges().listen((auth.User event) {
      if (event == null) {
        callSubscription.cancel();
      }
    });
  }

  String getConnectionID(String friendID) {
    String connectionID;
    String selfID = HomeScreenState.currentUser.userID;
    if (friendID.compareTo(selfID) < 0) {
      connectionID = friendID + selfID;
    } else {
      connectionID = selfID + friendID;
    }
    return connectionID;
  }
}

class OBHomeScreenController extends PoppablePageController {}
