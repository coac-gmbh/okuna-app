import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String email;

  String firstName;

  String lastName;

  UserSettings settings;

  String phoneNumber;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;

  String username;
  String profilePictureURL;

  String appIdentifier = 'Flutter Dating ${Platform.operatingSystem}';

  String fcmToken;

  bool isVip;

  bool showMe;

  String bio;

  String school;

  String age;

  List<dynamic> photos;

  //internal use only, don't save to db
  String milesAway = '0 Miles Away';

  bool selected = false;

  User({
    this.email = '',
    this.userID = '',
    this.profilePictureURL = '',
    this.firstName = '',
    this.phoneNumber = '',
    this.lastName = '',
    this.username = '',
    this.active = false,
    lastOnlineTimestamp,
    settings,
    this.fcmToken = '',
    this.isVip = false,

    //tinder related fields
    this.showMe = true,
    this.school = '',
    this.age = '',
    this.bio = '',
    this.photos = const [],
  })  : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.settings = settings ?? UserSettings();

  String fullName() {
    return '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        username: parsedJson['username'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        settings: parsedJson.containsKey('settings')
            ? UserSettings.fromJson(parsedJson['settings'])
            : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        //dating app related fields
        showMe: parsedJson['showMe'] ?? parsedJson['showMeOnTinder'] ?? true,
        school: parsedJson['school'] ?? 'N/A',
        age: parsedJson['age'] ?? '',
        bio: parsedJson['bio'] ?? 'N/A',
        photos: parsedJson['photos'] ?? [].cast<String>());
  }

  factory User.fromPayload(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        username: parsedJson['username'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: Timestamp.fromMillisecondsSinceEpoch(
            parsedJson['lastOnlineTimestamp']),
        settings: parsedJson.containsKey('settings')
            ? UserSettings.fromJson(parsedJson['settings'])
            : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        school: parsedJson['school'] ?? 'N/A',
        age: parsedJson['age'] ?? '',
        bio: parsedJson['bio'] ?? 'N/A',
        showMe: parsedJson['showMe'] ?? parsedJson['showMeOnTinder'] ?? true,
        photos: parsedJson['photos'] ?? [].cast<String>());
  }

  Map<String, dynamic> toJson() {
    photos.toList().removeWhere((element) => element == null);
    return {
      "email": this.email,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "username": this.username,
      "settings": this.settings.toJson(),
      "phoneNumber": this.phoneNumber,
      "id": this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      "profilePictureURL": this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'fcmToken': this.fcmToken,

      //tinder related fields
      'showMe': this.settings.showMe,
      'bio': this.bio,
      'school': this.school,
      'age': this.age,
      'photos': this.photos,
    };
  }

  Map<String, dynamic> toPayload() {
    photos.toList().removeWhere((element) => element == null);
    return {
      "email": this.email,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "username": this.username,
      "settings": this.settings.toJson(),
      "phoneNumber": this.phoneNumber,
      "id": this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp.millisecondsSinceEpoch,
      "profilePictureURL": this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'fcmToken': this.fcmToken,
      'showMe': this.settings.showMe,
      'bio': this.bio,
      'school': this.school,
      'age': this.age,
      'isVip': this.isVip,
      'photos': this.photos,
    };
  }
}

class UserSettings {
  bool pushNewMessages;

  bool pushNewMatchesEnabled;

  bool pushSuperLikesEnabled;

  bool pushTopPicksEnabled;

  String genderPreference; // should be either "Male" or "Female" // or "All"

  String gender; // should be either "Male" or "Female"

  String distanceRadius;

  bool showMe;

  UserSettings({
    this.pushNewMessages = true,
    this.pushNewMatchesEnabled = true,
    this.pushSuperLikesEnabled = true,
    this.pushTopPicksEnabled = true,
    this.genderPreference = 'Female',
    this.gender = 'Male',
    this.distanceRadius = '10',
    this.showMe = true,
  });

  factory UserSettings.fromJson(Map<dynamic, dynamic> parsedJson) {
    return new UserSettings(
      pushNewMessages: parsedJson['pushNewMessages'] ?? true,
      pushNewMatchesEnabled: parsedJson['pushNewMatchesEnabled'] ?? true,
      pushSuperLikesEnabled: parsedJson['pushSuperLikesEnabled'] ?? true,
      pushTopPicksEnabled: parsedJson['pushTopPicksEnabled'] ?? true,
      genderPreference: parsedJson['genderPreference'] ?? 'Female',
      gender: parsedJson['gender'] ?? 'Male',
      distanceRadius: parsedJson['distanceRadius'] ?? '10',
      showMe: parsedJson['showMe'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNewMessages': this.pushNewMessages,
      'pushNewMatchesEnabled': this.pushNewMatchesEnabled,
      'pushSuperLikesEnabled': this.pushSuperLikesEnabled,
      'pushTopPicksEnabled': this.pushTopPicksEnabled,
      'genderPreference': this.genderPreference,
      'gender': this.gender,
      'distanceRadius': this.distanceRadius,
      'showMe': this.showMe
    };
  }
}
