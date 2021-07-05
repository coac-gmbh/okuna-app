import 'package:Okuna/matchmaking/CustomFlutterTinderCard.dart';
import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/User.dart' as current;
import 'package:Okuna/matchmaking/pages/CardProfileScreen.dart';
import 'package:Okuna/matchmaking/pages/UserDetailsScreen.dart';
import 'package:Okuna/matchmaking/pages/MatchScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/models/user_profile.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/profile_card.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_cover.dart';
import 'package:Okuna/widgets/buttons/actions/follow_button.dart';
import 'package:Okuna/widgets/nav_bars/themed_nav_bar.dart';
import 'package:Okuna/widgets/theming/actionable_smart_text.dart';
import 'package:Okuna/widgets/theming/primary_color_container.dart';
import 'package:Okuna/widgets/theming/secondary_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:Okuna/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeScreen extends StatefulWidget {
  final current.User user;
  final User cardUser;

  const SwipeScreen({Key key, this.user, this.cardUser}) : super(key: key);
  
  @override
  SwipeScreenState createState() => SwipeScreenState();
}

class SwipeScreenState extends State<SwipeScreen> with WidgetsBindingObserver {
  static current.User currentUser;
  static User cardUser;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  Stream<List<current.User>> tinderUsers;
  List<current.User> swipedUsers = [];
  List<current.User> users = [];
  CardController controller = CardController();



  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;


  void initializeFlutterFire() async {
    setState(() {
      currentUser = widget.user;
      cardUser = User(
        id: 8,
        uuid: 'df6e0a85-39fb-4a8e-adc0-73cf66115e33', 
        dateJoined: DateTime.parse('2021-06-01 15:03:00.765629').toLocal() , 
        connectionsCircleId: 9, 
        email: 'ashley@helixsoft.com.co', 
        username: 'ash',
        visibility: UserVisibility.public, 
        notificationsSettings: null, 
        followersCount: null, 
        followingCount: 1, 
        postsCount: 4, 
        isBlocked: false,
        profile: 
          UserProfile(
              id: 7, 
              name: 'Ashley', 
              avatar: 'http://h2.dev.altix.co/media/users/8/038ea871-bd31-4609-8450-c9fc2117b38a.jpg', 
              cover: 'http://h2.dev.altix.co/media/users/8/e3954a8c-9cd4-4dd8-a000-29c28adeb0f3.jpg', 
              bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in metus id eros vulputate molestie vel vel nulla. In et dictum metus. Nam in orci elit. Maecenas elit nulla, lacinia vitae orci in, ultricies pharetra velit. Nulla lorem lorem, dapibus mollis condimentum et, tempus sed lectus. Praesent lobortis, libero quis porttitor ultricies, diam ipsum accumsan dui, id imperdiet dui turpis sed velit. Integer eu aliquet lorem.', 
              url: null, location: null, badges: []),
              
      );
    });
    try {
      _setupTinder();
      setState(() {
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
    if (auth.FirebaseAuth.instance.currentUser != null && currentUser != null) {
      if (state == AppLifecycleState.paused) {
        //user offline
        // tokenStream.pause();
        currentUser.active = false;
        currentUser.lastOnlineTimestamp = Timestamp.now();
        FireStoreUtils.updateCurrentUser(currentUser);
      } else if (state == AppLifecycleState.resumed) {
        //user online
        // tokenStream.resume();
        currentUser.active = true;
        FireStoreUtils.updateCurrentUser(currentUser);
      }
    }
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
                  totalNum: data.length,
                  stackNum: 3,
                  swipeEdge: 15,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width * 0.9,
                  minHeight: MediaQuery.of(context).size.height * 0.9,
                  cardBuilder: (context, index) => _buildCard(data[index]),
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
                  heroTag: 'center',
                  onPressed: () {
                    controller.triggerRight();
                  },
                  backgroundColor: Colors.white,
                  mini: true,
                  child: Icon(
                    Icons.star,
                    color: Colors.blue,
                    size: 30,
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
  }



  Widget _buildCard(current.User tinderUser) {
    return GestureDetector(
      onTap: () async {
        _launchDetailsScreen(tinderUser);
      },
      child: Card(
        child: Stack(
          children: <Widget>[
            CardProfileScreen(user: cardUser,),
            Positioned(
              right: 5,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 30,
                onPressed: () => _onCardSettingsClick(tinderUser),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Visibility(
                visible: swipedUsers.isNotEmpty,
                child: FloatingActionButton(
                  heroTag: '${tinderUser.userID}',
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
      ),
    );
  }


  Future<void> _launchDetailsScreen(current.User tinderUser) async {
    CardSwipeOrientation result = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) => UserDetailsScreen(
          user: tinderUser,
          isMatch: false,
        ),
      ),
    );
    if (result != null) {
      if (result == CardSwipeOrientation.LEFT) {
        controller.triggerLeft();
      } else {
        controller.triggerRight();
      }
    }
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