
import 'dart:async';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

//helper method to show progress
ProgressDialog progressDialog;

showProgress(BuildContext context, String message, bool isDismissible) async {
  progressDialog = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: isDismissible);
  progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Color(COLOR_PRIMARY),
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));

  await progressDialog.show();
}

updateProgress(String message) {
  progressDialog.update(message: message);
}

hideProgress() async {
  await progressDialog.hide();
}

//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content) {
  // set up the AlertDialog
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.maybePop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => destination));
}

skipNulls<Widget>(List<Widget> items) {
  return items..removeWhere((item) => item == null);
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
          (Route<dynamic> route) => predict);
}

Widget _getCircularImageProvider(ImageProvider provider, double size, bool hasBorder) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      borderRadius: new BorderRadius.all(new Radius.circular(size / 2)),
      border: new Border.all(
        color: Colors.white,
        width: hasBorder ? 2.0 : 0.0,
      ),
    ),
    child: ClipOval(
        child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: Image.asset(
              'assets/images/placeholder.jpg',
              fit: BoxFit.cover,
              height: size,
              width: size,
            ).image,
            image: provider)),
  );
}

Widget _getPlaceholderOrErrorImage(double size, hasBorder) => Container(
  width: size,
  height: size,
  decoration: BoxDecoration(
    color: const Color(0xff7c94b6),
    borderRadius: new BorderRadius.all(new Radius.circular(size / 2)),
    border: new Border.all(
      color: Colors.white,
      width: hasBorder ? 2.0 : 0.0,
    ),
  ),
  child: ClipOval(
      child: Image.asset(
        'assets/images/fallbacks/avatar-fallback.jpg',
        fit: BoxFit.cover,
        height: size,
        width: size,
      )),
);

Widget displayCircleImage(String picUrl, double size, hasBorder) =>
    ExtendedImage.network(
        picUrl,
        fit: BoxFit.cover,
        cache: true,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Center(child: OBProgressIndicator());
              break;
            case LoadState.completed:
              return null;
              break;
            case LoadState.failed:
              return _getPlaceholderOrErrorImage(size, hasBorder);
              break;
            default:
              return _getPlaceholderOrErrorImage(size, hasBorder);
              break;  
          }
        },
      );
            

String setLastSeen(int seconds) {
  var format = DateFormat('hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  var diff = DateTime.now().millisecondsSinceEpoch - (seconds * 1000);
  if (diff < 24 * HOUR_MILLIS) {
    return format.format(date);
  } else if (diff < 48 * HOUR_MILLIS) {
    return 'Yesterday at ${format.format(date)}';
  } else {
    format = DateFormat('MMM d');
    return '${format.format(date)}';
  }
}


String updateTime(Timer timer) {
  Duration callDuration = Duration(seconds: timer.tick);
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitsHours(int n) {
    if (n >= 10) return "$n:";
    if (n == 0) return '';
    return "0$n:";
  }

  String twoDigitMinutes = twoDigits(callDuration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(callDuration.inSeconds.remainder(60));
  return "${twoDigitsHours(callDuration.inHours)}$twoDigitMinutes:$twoDigitSeconds";
}


String formatTimestamp(int timestamp) {
  var format = new DateFormat('hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => destination));
}

bool isDarkMode(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return false;
  } else {
    return true;
  }
}
