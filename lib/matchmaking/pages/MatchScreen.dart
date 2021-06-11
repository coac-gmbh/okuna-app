import 'package:Okuna/matchmaking/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MatchScreen extends StatefulWidget {
  final User matchedUser;

  const MatchScreen({ Key key, @required this.matchedUser }) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
      
    );
  }


}


