import 'dart:async';

import 'package:Okuna/matchmaking/CustomFlutterTinderCard.dart';
import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/ProfileCardUser.dart';
import 'package:Okuna/matchmaking/model/User.dart' as current;
import 'package:Okuna/models/user.dart';
import 'package:Okuna/matchmaking/pages/CardProfileScreen.dart';
import 'package:Okuna/matchmaking/pages/MatchScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  final current.User user;
  const SwipeScreen({Key key, this.user}) : super(key: key);
  
  @override
  SwipeScreenState createState() => SwipeScreenState();
}

class SwipeScreenState extends State<SwipeScreen> with WidgetsBindingObserver {
  static current.User firebaseUser;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  Stream<List<current.User>> tinderUsers;
  List<current.User> swipedUsers = [];
  List<current.User> users = [];
  UserService _userService;
  CardController controller = CardController();


  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  bool _needsBootstrap;


  void initializeFlutterFire() async {
    setState(() {
      firebaseUser = widget.user;
    });
    try {
      _setupTinder();
      setState(() {
        _needsBootstrap = true;
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
    WidgetsBinding.instance?.addObserver(this);
  }
  

  @override
  void dispose() {
    // tokenStream.cancel();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (auth.FirebaseAuth.instance.currentUser != null && firebaseUser != null) {
      if (state == AppLifecycleState.paused) {
        //user offline
        // tokenStream.pause();
        firebaseUser.active = false;
        firebaseUser.lastOnlineTimestamp = Timestamp.now();
        FireStoreUtils.updateCurrentUser(firebaseUser);
      } else if (state == AppLifecycleState.resumed) {
        //user online
        // tokenStream.resume();
        firebaseUser.active = true;
        FireStoreUtils.updateCurrentUser(firebaseUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {


    var openbookProvider = OpenbookProvider.of(context);
    if (_needsBootstrap) {
      _userService = openbookProvider.userService;
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (_error) {
      return Container(
        color: Colors.white,
        child: Center(
            child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 25,
            ),
            SizedBox(height: 16),
            Text(
              'Oh no! There is an error. Try again later',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          ],
        )),
      );
    }

    return StreamBuilder<List<current.User>>(
      stream: tinderUsers,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
              ),
            );
          case ConnectionState.active:
            return _asyncCards(context, snapshot.data);
          case ConnectionState.done:
        }
        return Container(); // unreachable
      },
    );
  }


  Stream<List<ProfileCardUser>> _getFullUserInformation(List<current.User> data) async* {
  StreamController<List<ProfileCardUser>> profileCardsStreamController = StreamController<List<ProfileCardUser>>();
    List<ProfileCardUser> extendedUsers = [];
    data.forEach((current.User basicInformation) async { 
      print(basicInformation.username);
      _userService.getUserWithUsername(basicInformation.username).then((value) {
        try {
          ProfileCardUser _extended = ProfileCardUser(
            basicInformation: basicInformation, 
            extendedInformation: value
          );
          extendedUsers.add(_extended);
          profileCardsStreamController.add(extendedUsers);
        } catch (e) {
          print(e);
        }

      });
    });


    yield* profileCardsStreamController.stream;

  }


  Widget _asyncCards(BuildContext context, List<current.User> data) {
    users = data ?? [];
    if (data == null || data.isEmpty)
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'There’s no one around you. Try increasing the distance radius to get more recommendations.',
            textAlign: TextAlign.center,
          ),
        ),
      );


    return StreamBuilder<List<ProfileCardUser>>(
      stream: _getFullUserInformation(data),
      builder: (context, snapshot) {

        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
              ),
            );
          case ConnectionState.active:
          print(snapshot.data);
            return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Stack(children: [
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'There’s no one around you. Try increasing '
                              'the distance radius to get more recommendations.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.9,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: new TinderSwapCard(
                      animDuration: 500,
                      orientation: AmassOrientation.BOTTOM,
                      totalNum: snapshot.data.length,
                      stackNum: 3,
                      swipeEdge: 15,
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: MediaQuery.of(context).size.height * 0.9,
                      cardBuilder: (context, index) => _buildCard(snapshot.data[index]),
                      cardController: controller,
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) async {
                        if (orientation == CardSwipeOrientation.LEFT ||
                            orientation == CardSwipeOrientation.RIGHT) {
                            if (orientation == CardSwipeOrientation.RIGHT) {
                              current.User result =
                                  await _fireStoreUtils.onSwipeRight(data[index]);
                              if (result != null) {
                                data.removeAt(index);
                                _fireStoreUtils.updateCardStream(data);
                                push(context, MatchScreen(matchedUser: result));
                              } else {
                                swipedUsers.add(data[index]);
                                data.removeAt(index);
                                _fireStoreUtils.updateCardStream(data);
                              }
                            } else if (orientation == CardSwipeOrientation.LEFT) {
                              swipedUsers.add(data[index]);
                              await _fireStoreUtils.onSwipeLeft(data[index]);
                              data.removeAt(index);
                              _fireStoreUtils.updateCardStream(data);
                            }
                        }
                      },
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      elevation: 1,
                      heroTag: 'left',
                      onPressed: () {
                        controller.triggerLeft();
                      },
                      backgroundColor: Colors.white,
                      mini: false,
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    FloatingActionButton(
                      elevation: 1,
                      heroTag: 'right',
                      onPressed: () {
                        controller.triggerRight();
                      },
                      backgroundColor: Colors.white,
                      mini: false,
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                        size: 35,
                      ),
                    )
                  ],
                ),
              )
            ]);
     
          case ConnectionState.done:
        }
        return Container(); // unreachable
         }
    );
  }



  Widget _buildCard(ProfileCardUser extendedUser) {
    return Card(
      child: Stack(
        children: <Widget>[
          CardProfileScreen(extendedUser: extendedUser,),
          Positioned(
            right: 5,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              iconSize: 30,
              onPressed: () => _onCardSettingsClick(extendedUser.basicInformation),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Visibility(
              visible: swipedUsers.isNotEmpty,
              child: FloatingActionButton(
                heroTag: '${extendedUser.basicInformation.userID}',
                backgroundColor: Color(COLOR_PRIMARY),
                mini: true,
                child: Icon(
                  Icons.undo,
                  color: Colors.white,
                ),
                onPressed: () => _undo(),
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.white,
    );
  }

  _onCardSettingsClick(current.User user) {
    final action = CupertinoActionSheet(
      message: Text(
        user.fullName(),
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Block user"),
          onPressed: () async {
            Navigator.pop(context);
            showProgress(context, 'Blocking user...', false);
            bool isSuccessful = await _fireStoreUtils.blockUser(
                user, 'block');
            hideProgress();
            if (isSuccessful) {
              await _fireStoreUtils.onSwipeLeft(user);
              users.remove(user);
              _fireStoreUtils.updateCardStream(users);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${user.fullName()} has been blocked.'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Couldn\'t block ${user.fullName()}, please try again later.'),
                ),
              );
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Report user"),
          onPressed: () async {
            Navigator.pop(context);
            showProgress(context, 'Reporting user...', false);
            bool isSuccessful = await _fireStoreUtils.blockUser(
                user, 'report');
            hideProgress();
            if (isSuccessful) {
              await _fireStoreUtils.onSwipeLeft(user);
              users.removeWhere((element) => element.userID == user.userID);
              _fireStoreUtils.updateCardStream(users);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${user.fullName()} has been reported and blocked.'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Couldn\'t report ${user.fullName()}, please try again later.'),
                ),
              );
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }


  _undo() async {
      current.User undoUser = swipedUsers.removeLast();
      users.insert(0, undoUser);
      _fireStoreUtils.updateCardStream(users);
      await _fireStoreUtils.undo(undoUser);
  }

  _setupTinder() async {
    tinderUsers = _fireStoreUtils.getTinderUsers();
  //   await _fireStoreUtils.matchChecker(context);
  }
}