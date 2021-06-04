import 'package:flutter/material.dart';

class OBSplashLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/openbook-o-logo.png',
          height: 150.0,
          width: 135.0,
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 10.0),
        //   width: 2.0,
        //   height: 20.0,
        //   decoration: BoxDecoration(
        //       color: Colors.black12,
        //       borderRadius: BorderRadius.circular(100.0)),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(top: 10),
        //   child: Text('H2pro3',
        //       style: TextStyle(fontSize: 38.0, fontFamily: 'NunitoSansBold'
        //           //color: Colors.white
        //           )),
        // ),
      ],
    );
  }
}
