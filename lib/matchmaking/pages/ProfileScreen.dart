import 'dart:io';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/pages/auth/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  User user;
  FireStoreUtils _fireStoreUtils = FireStoreUtils();
  List images = [];
  List _pages = [];
  List<Widget> _gridPages = [];
  PageController controller = PageController();




  @override
  void initState() {
    user = widget.user;
    images.clear();
    images.addAll(user.photos);
    if (images.isNotEmpty) {
      if (images[images.length - 1] != null) {
        images.add(null);
      }
    } else {
      images.add(null);
    }
    super.initState();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [

            Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Center(
                    child:
                        displayCircleImage(user.profilePictureURL, 130, false)),
                Positioned(
                  left: 80,
                  right: 0,
                  child: FloatingActionButton(
                      heroTag: 'pickImage',
                      backgroundColor: Color(COLOR_ACCENT),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      mini: true,
                      onPressed: _onCameraClick),
                )
              ],
            ),
          ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 32, left: 32),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  user.fullName(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: skipNulls([
                  Text(
                    'My Photos',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  _pages.length >= 2
                      ? SmoothPageIndicator(
                          controller: controller,
                          count: _pages.length,
                          effect: ScrollingDotsEffect(
                            activeDotColor: Color(COLOR_ACCENT),
                            dotColor: Colors.grey,
                          ),
                        )
                      : null
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: SizedBox(
                height: user.photos.length > 3 ? 260 : 130,
                width: double.infinity,
                child: PageView(
                  children: _gridPages,
                  controller: controller,
                ),
              ),
            ), 

            Column(
            children: <Widget>[
              ListTile(
                dense: true,
                onTap: () {
                  // push(context, new AccountDetailsScreen(user: user));
                },
                title: Text(
                  'Account Details',
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  // push(context, new SettingsScreen(user: user));
                },
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black45,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  // push(context, new ContactUsScreen());
                },
                title: Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              ),
            ],
          ), 

          ],
        ),
      ),
      
    );
  }


  Future<void> _imagePicked(File image) async {
    showProgress(context, 'Uploading image...', false);
    user.profilePictureURL =
        await FireStoreUtils.uploadUserImageToFireStorage(image, user.userID);
    await FireStoreUtils.updateCurrentUser(user);
    HomeScreenState.currentUser = user;
    hideProgress();
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add profile picture",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Remove Picture"),
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);
            showProgress(context, 'Removing picture...', false);
            if (user.profilePictureURL.isNotEmpty)
              await _fireStoreUtils.deleteImage(user.profilePictureURL);
            user.profilePictureURL = '';
            await FireStoreUtils.updateCurrentUser(user);
            HomeScreenState.currentUser = user;
            hideProgress();
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.gallery);
            if (image != null) {
              await _imagePicked(File(image.path));
            }
            setState(() {});
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.camera);
            if (image != null) {
              await _imagePicked(File(image.path));
            }
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

}