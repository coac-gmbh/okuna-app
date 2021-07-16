import 'package:Okuna/models/category.dart';
import 'package:Okuna/models/community_membership.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/theme_value_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBadge extends StatelessWidget {
  final OBCategoryBadgeSize size;
  final Category category;
  final CommunityMembership community;


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
        text: category != null ? category.name : community.communityTitle,
        textColor: badgeIsDark ? Colors.white : Colors.black);
  }
  
  Widget _buildBadge({@required Color color, @required Color textColor, @required text}) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: 14),
        ),
      ),
    );
  }
}

enum OBCategoryBadgeSize { medium, large, small }
