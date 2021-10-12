import 'package:flutter/material.dart';

class OBBadgeTab extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  const OBBadgeTab({ Key key, this.color, this.textColor, this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}