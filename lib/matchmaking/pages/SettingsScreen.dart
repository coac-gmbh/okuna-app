
import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatefulWidget {
  final User user;

  const SettingsScreen({Key key, @required this.user}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User user;

  bool showMe, newMatches, messages, superLikes, topPicks;

  String radius, gender, prefGender;

  @override
  void initState() {
    user = widget.user;
    showMe = user.showMe;
    newMatches = user.settings.pushNewMatchesEnabled;
    messages = user.settings.pushNewMessages;
    superLikes = user.settings.pushSuperLikesEnabled;
    topPicks = user.settings.pushTopPicksEnabled;
    radius = user.settings.distanceRadius;
    gender = user.settings.gender;
    prefGender = user.settings.genderPreference;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
            builder: (buildContext) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16, top: 16, bottom: 8),
                  child: Text(
                    'Discovery',
                    style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.white54 : Colors.black54, fontSize: 18),
                  ),
                ),
                Material(
                  elevation: 2,
                  color: isDarkMode(context)
                      ? Colors.black12 : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SwitchListTile.adaptive(
                          activeColor: Color(COLOR_ACCENT),
                          title: Text(
                            'Show me',
                            style: TextStyle(
                              fontSize: 17,
                              color: isDarkMode(context)
                                  ? Colors.white : Colors.black,
                            ),
                          ),
                          value: showMe,
                          onChanged: (bool newValue) {
                            showMe = newValue;
                            setState(() {});
                          }),
                      ListTile(
                        title: Text(
                          'Distance Radius',
                          style: TextStyle(
                            fontSize: 17,
                            color: isDarkMode(context)
                                ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: _onDistanceRadiusClick,
                          child: Text(
                                  radius.isNotEmpty
                                      ? '$radius Miles'
                                      : 'Unlimited',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: isDarkMode(context)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 17,
                            color: isDarkMode(context)
                                ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: _onGenderClick,
                          child: Text('$gender',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: isDarkMode(context)
                                      ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16, top: 16, bottom: 8),
                  child: Text(
                    'Push Notifications',
                    style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.white54 : Colors.black54, fontSize: 18),
                  ),
                ), Material(
                  elevation: 2,
                  color: isDarkMode(context)
                      ? Colors.black12 : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SwitchListTile.adaptive(
                          activeColor: Color(COLOR_ACCENT),
                          title: Text(
                            'New matches',
                            style: TextStyle(
                              fontSize: 17,
                              color: isDarkMode(context)
                                  ? Colors.white : Colors.black,
                            ),
                          ),
                          value: newMatches,
                          onChanged: (bool newValue) {
                            newMatches = newValue;
                            setState(() {});
                          }),
                      Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SwitchListTile.adaptive(
                              activeColor: Color(COLOR_ACCENT),
                              title: Text(
                                'Messages',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: isDarkMode(context)
                                      ? Colors.white : Colors.black,
                                ),
                              ),
                              value: messages,
                              onChanged: (bool newValue) {
                                messages = newValue;
                                setState(() {});
                              })),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 16),
                  child: ConstrainedBox(
                    constraints:
                    const BoxConstraints(minWidth: double.infinity),
                    child: Material(
                      elevation: 2,
                      color: isDarkMode(context)
                          ? Colors.black12 : Colors.white,
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(12.0),
                        onPressed: () async {
                          showProgress(context, 'Saving changes...', true);
                              user.settings.genderPreference = prefGender;
                              user.settings.gender = gender;
                              user.settings.showMe = showMe;
                              user.showMe = showMe;
                              user.settings.pushTopPicksEnabled = topPicks;
                              user.settings.pushNewMessages = messages;
                              user.settings.pushSuperLikesEnabled = superLikes;
                              user.settings.pushNewMatchesEnabled = newMatches;
                              user.settings.distanceRadius = radius;
                          User updateUser =
                                  await FireStoreUtils.updateCurrentUser(user);
                              hideProgress();
                              if (updateUser != null) {
                                this.user = updateUser;
                                HomeScreenState.currentUser = user;
                                ScaffoldMessenger.of(buildContext).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text(
                                      'Settings saved successfully',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                );
                              }
                            },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 18, color: Color(COLOR_PRIMARY)),
                        ),
                        color: isDarkMode(context)
                            ? Colors.black12 : Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  _onDistanceRadiusClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Distance Radius",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("5 Miles"),
          isDefaultAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '5';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("10 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '10';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("15 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '15';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("20 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '20';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("25 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '25';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("50 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '50';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("100 Miles"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '100';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Unlimited"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            radius = '';
            setState(() {});
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _onGenderClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Gender",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Female"),
          isDefaultAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            gender = 'Female';
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Male"),
          isDestructiveAction: false,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("1");
            gender = 'Male';
            setState(() {});
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop("1");
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

}
