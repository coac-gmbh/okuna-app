import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/ConversationsScreen.dart';
import 'package:Okuna/matchmaking/pages/ProfileScreen.dart';
import 'package:Okuna/matchmaking/pages/SwipeScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/pages/home/lib/poppable_page_controller.dart';
import 'package:firebase_core/firebase_core.dart';
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
  FireStoreUtils _fireStoreUtils = FireStoreUtils();


  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;


  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      await _loginWithEmailAndPassword();
      setState(() {
        _initialized = true;
      });
      if(_initialized){
        _currentWidget = SwipeScreen(user: currentUser,);
      }
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
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    _currentWidget = SwipeScreen();
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
        }));
  }

  /// login with email and password with firebase
  /// @param email user email
  /// @param password user password
  _loginWithEmailAndPassword() async {
    // dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
    //     email!.trim(), password!.trim());
    dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
        'angelaramiez@abc.com', '12345ABcd\$');
    if (result != null && result is User) {
      setState(() {
        currentUser = result;
      });
    } else if (result != null && result is String) {
      setState(() {
        _error = true;
      });
      showAlertDialog(context, 'Couldn\'t Authenticate', result);
    } else {
      setState(() {
        _error = true;
      });
      showAlertDialog(context, 'Couldn\'t Authenticate',
          'Login failed, Please try again.');
    }
  }    
}

class OBHomeScreenController extends PoppablePageController {}
