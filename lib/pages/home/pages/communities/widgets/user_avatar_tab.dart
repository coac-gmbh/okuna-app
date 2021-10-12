import 'package:Okuna/models/theme.dart';
import 'package:Okuna/models/user.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/theme.dart';
import 'package:Okuna/services/theme_value_parser.dart';
import 'package:Okuna/widgets/alerts/alert.dart';
import 'package:Okuna/widgets/tabs/image_tab.dart';
import 'package:flutter/material.dart';

class OBUserAvatarTab extends StatelessWidget {
  final User user;

  const OBUserAvatarTab({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OpenbookProviderState openbookProvider = OpenbookProvider.of(context);
    ThemeService _themeService = openbookProvider.themeService;
    ThemeValueParserService _themeValueParser =
        openbookProvider.themeValueParserService;
    OBTheme theme = _themeService.getActiveTheme();

    Gradient themeGradient =
        _themeValueParser.parseGradient(theme.primaryAccentColor);

    return OBAlert(
        borderRadius: BorderRadius.circular(OBImageTab.borderRadius),
        padding: EdgeInsets.all(0),
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        decoration: BoxDecoration(
            gradient: themeGradient,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          'You',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
