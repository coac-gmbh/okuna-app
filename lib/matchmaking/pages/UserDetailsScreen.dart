import 'package:Okuna/matchmaking/model/User.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;
  final bool isMatch;

  const UserDetailsScreen({Key key, @required this.user, @required this.isMatch})
      : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}