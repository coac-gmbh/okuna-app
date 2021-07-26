import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/ProfileCardUser.dart';
import 'package:Okuna/matchmaking/widgets/Badge.dart';
import 'package:Okuna/models/badge.dart';
import 'package:Okuna/models/categories_list.dart';
import 'package:Okuna/models/community_membership_list.dart';
import 'package:Okuna/models/theme.dart';
import 'package:Okuna/models/user.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_bio.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_counts/profile_counts.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_details/profile_details.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_details/widgets/profile_age.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_details/widgets/profile_url.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_name.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_username.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_cover.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/toast.dart';
import 'package:Okuna/widgets/avatars/avatar.dart';
import 'package:Okuna/widgets/theming/actionable_smart_text.dart';
import 'package:Okuna/widgets/theming/primary_color_container.dart';
import 'package:Okuna/widgets/user_badge.dart';
import 'package:Okuna/widgets/user_posts_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardProfileScreen extends StatefulWidget {
  final ProfileCardUser extendedUser;


  const CardProfileScreen({ Key key, @required this.extendedUser, }) : super(key: key);

  @override
  _CardProfileScreenState createState() => _CardProfileScreenState();
}

class _CardProfileScreenState extends State<CardProfileScreen> {
  

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var openbookProvider = OpenbookProvider.of(context);
    var themeService = openbookProvider.themeService;
    var themeValueParserService = openbookProvider.themeValueParserService;
    var toastService = openbookProvider.toastService;



    List<Container> _buildCategoriesList(CategoriesList _categories) {
      List<Container> _categoriesWidget = [];
      if(_categories != null){
        for (var category in _categories.categories) {
          _categoriesWidget.add(
            Container(
              padding: EdgeInsets.only(right: 10),
              child: TextBadge(category: category),
            )
          );
        }
      }
      return _categoriesWidget;
    }

    List<Container> _buildCommunitiesList(CommunityMembershipList _communities) {
      List<Container> _communitiesWidget = [];
      if(_communities != null){
        for (var community in _communities.communityMemberships) {
          _communitiesWidget.add(
            Container(
              padding: EdgeInsets.only(right: 10),
              child: TextBadge(community: community),
            )
          );
        }
      }

      return _communitiesWidget;
    }

    User _user = widget.extendedUser.extendedInformation;

    return Container(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CupertinoPageScaffold(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            child: OBPrimaryColorContainer(
              child: Column(
                children:[
                  Container(height: 140,child: OBProfileCover(_user)),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 18.0, right: 18),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: (OBAvatar.AVATAR_SIZE_MEDIUM * 0.2),
                              width: OBAvatar.AVATAR_SIZE_MEDIUM,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OBProfileName(_user),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.18,
                                      child: OBProfileAge(_user),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OBProfileUsername(_user),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.18,
                                      child: OBUserPostsCount(_user),
                                    )
                                  ],
                                ),

                                _user.profile.bio != null ? Container(
                                  height: 65,
                                  child: OBProfileBio(user: _user, size: OBTextSize.small,)
                                ) : SizedBox(),


                                OBProfileUrl(_user),

                                _user.categories.categories.length >0 ?  Column(
                                  children: [
                                    const Divider(height: 20,),
                                    Container(
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('CATEGORIES', style: TextStyle(fontSize: 8),),
                                            const SizedBox( height: 5),
                                            Container(
                                              height: 30,
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: _buildCategoriesList(_user.categories),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ]) : SizedBox(),

                                _user.communitiesMemberships.communityMemberships.length > 0
                                  ?  Column(
                                        children: [
                                          const Divider(height: 20,),
                                          Container(
                                            height: 50,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('GROUPS', style: TextStyle(fontSize: 8),),
                                                const SizedBox( height: 5),
                                                Container(
                                                  height: 30,
                                                  child: ListView(
                                                    scrollDirection: Axis.horizontal,
                                                    children: _buildCommunitiesList(_user.communitiesMemberships),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]) : SizedBox(),


                              ]),
                          ],
                        ),
                      ),
                      Positioned(
                        child: StreamBuilder(
                          stream: themeService.themeChange,
                          initialData: themeService.getActiveTheme(),
                          builder: (BuildContext context, AsyncSnapshot<OBTheme> snapshot) {
                            var theme = snapshot.data;

                            return Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: themeValueParserService.parseColor(theme.primaryColor),
                                borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                              );
                            },
                          ),
                        top: -19,
                      ),
                      Positioned(
                        top: -((OBAvatar.AVATAR_SIZE_MEDIUM/ 2)) - 10,
                        left: 18,
                        child: StreamBuilder(
                          stream: _user.updateSubject,
                          initialData: _user,
                          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                            var user = snapshot.data;

                            return OBAvatar(
                              borderWidth: 3,
                              avatarUrl: user?.getProfileAvatar(),
                              size: OBAvatarSize.medium,
                              isZoomable: false,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ]
              ),   
            )
          ),
        ),
      ),
    );
  }

}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
        ),
      ),
    );
  }
}