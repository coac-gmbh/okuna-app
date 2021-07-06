import 'package:Okuna/models/category.dart';
import 'package:Okuna/models/community.dart';
import 'package:Okuna/models/theme.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/theme_value_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBadge extends StatelessWidget {
  final OBCategoryBadgeSize size;
  final Category category;
  final Community community;


  const TextBadge({
    Key key,
    this.size = OBCategoryBadgeSize.medium, this.category, this.community,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeValueParserService themeValueParserService =
        OpenbookProvider.of(context).themeValueParserService;
    Color badgeColor = themeValueParserService.parseColor(category != null ? category.color : community.color);
    final bool badgeIsDark = themeValueParserService.isDarkColor(badgeColor);

    return _buildBadge(
        color: badgeColor,
        text: category != null ? category.name : community.name,
        textColor: badgeIsDark ? Colors.white : Colors.black);
  }
  
  Widget _buildBadge({@required Color color, @required Color textColor, @required text}) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      padding: _getPadding(),
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: _getFontSize()),
      ),
    );
  }

  EdgeInsets _getPadding() {
    EdgeInsets padding;

    switch (size) {
      case OBCategoryBadgeSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
        break;
      case OBCategoryBadgeSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 3);
        break;
      case OBCategoryBadgeSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 6);
        break;
      default:
        throw 'Unhandled category badge size';
    }

    return padding;
  }

  double _getFontSize() {
    double fontSize;

    switch (size) {
      case OBCategoryBadgeSize.small:
        fontSize = 14;
        break;
      case OBCategoryBadgeSize.medium:
        fontSize = 16;
        break;
      case OBCategoryBadgeSize.large:
        fontSize = 18;
        break;
      default:
        throw 'Unhandled category badge size';
    }

    return fontSize;
  }
}

enum OBCategoryBadgeSize { medium, large, small }
