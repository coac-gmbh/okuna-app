import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/widgets/Badge.dart';
import 'package:Okuna/models/badge.dart';
import 'package:Okuna/models/communities_list.dart';
import 'package:Okuna/models/community.dart';
import 'package:Okuna/models/theme.dart';
import 'package:Okuna/models/user.dart';
import 'package:Okuna/matchmaking/model/User.dart' as tinder;
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_bio.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_connected_in.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_connection_request.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_counts/profile_counts.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_details/profile_details.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_follow_request.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_in_lists.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_name.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_card/widgets/profile_username.dart';
import 'package:Okuna/pages/home/pages/profile/widgets/profile_cover.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/toast.dart';
import 'package:Okuna/services/user.dart';
import 'package:Okuna/widgets/avatars/avatar.dart';
import 'package:Okuna/widgets/nav_bars/themed_nav_bar.dart';
import 'package:Okuna/widgets/theming/primary_color_container.dart';
import 'package:Okuna/widgets/user_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardProfileScreen extends StatefulWidget {
  final tinder.User user;

  const CardProfileScreen({ Key key, @required this.user}) : super(key: key);

  @override
  _CardProfileScreenState createState() => _CardProfileScreenState();
}

class _CardProfileScreenState extends State<CardProfileScreen> {
  static User _user;
  UserService _userService;
  bool _needsBootstrap;
  bool _isLoading;

  @override
  void initState() {
    _needsBootstrap = true;
    _isLoading = true;
    super.initState();
  }

  List<Container> _buildCommunitiesList(){
    List<Container> _communities = [
      Container(
        padding: EdgeInsets.only(right: 10),
        child: TextBadge(
          community: Community.fromJSON({"id": 16, "creator": null, "name": "ash", "type": null, "rules": null, "avatar": null, "title": "AshCommunity", "user_adjective": null, "users_adjective": null, "description": null, "color": "#5a98ae", "cover": null, "is_invited": null, "are_new_post_notifications_enabled": null, "is_creator": null, "is_reported": null, "moderators": null, "memberships": [{"id": 34, "user_id": 19, "community_id": 16, "is_administrator": false, "is_moderator": false}], "administrators": null, "is_favorite": null, "invites_enabled": null, "members_count": null, "posts_count": 2, "pending_moderated_objects_count": null, "categories": null}
          )
        )
      ),
      Container(
        padding: EdgeInsets.only(right: 10),
        child: TextBadge(
          community: Community.fromJSON({"id": 14, "creator": null, "name": "testcamilo", "type": null, "rules": null, "avatar": null, "title": "TestCamilo", "user_adjective": "Member", "users_adjective": "Members", "description": null, "color": "#96C0FB", "cover": null, "is_invited": null, "are_new_post_notifications_enabled": null, "is_creator": null, "is_reported": null, "moderators": null, "memberships": null, "administrators": null, "is_favorite": false, "invites_enabled": null, "members_count": 3, "posts_count": null, "pending_moderated_objects_count": null, "categories": null}
          )
        )
      ),
    ];

    return _communities;
  }

  @override
  Widget build(BuildContext context) {

    var openbookProvider = OpenbookProvider.of(context);
    var themeService = openbookProvider.themeService;
    var themeValueParserService = openbookProvider.themeValueParserService;
    var toastService = openbookProvider.toastService;

    Future<void> _getOkunaUser(String id) async {
      var user = await _userService.getUserWithId('mike');
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }

    if (_needsBootstrap) {
      _userService = openbookProvider.userService;
      _needsBootstrap = false;
      _getOkunaUser(widget.user.userID);
    }

    return _isLoading == true
    ? LoadingContainer() 
    : Container(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CupertinoPageScaffold(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          navigationBar: OBThemedNavigationBar(title: '@' + widget.user.email),
          child: OBPrimaryColorContainer(
            child: Column(
              children:[
                Container(height: 170,child: OBProfileCover(_user)),
                Stack(
                  clipBehavior: Clip.none, 
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.0, right: 18),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: (OBAvatar.AVATAR_SIZE_EXTRA_LARGE * 0.2),
                            width: OBAvatar.AVATAR_SIZE_EXTRA_LARGE,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                               _buildNameRow(user: _user, context: context, toastService: toastService),
                              OBProfileUsername(_user),

                              Container( 
                                height: 65,
                                child: OBProfileBio(_user)
                              ),
                              const Divider(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('COMMUNITIES'),
                                    const SizedBox( height: 5),
                                    Container(
                                      height: 30,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: _buildCommunitiesList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('GROUPS'),
                                    const SizedBox( height: 5),
                                    Container(
                                      height: 30,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: _buildCommunitiesList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              OBProfileDetails(_user),
                              OBProfileCounts(_user),
                              OBProfileConnectedIn(_user),
                              OBProfileConnectionRequest(_user),
                              OBProfileFollowRequest(_user),
                              OBProfileInLists(_user),
                              
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
                                    color: themeValueParserService
                                        .parseColor(theme.primaryColor),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50))),
                              );
                            }),
                        top: -19,
                      ),
                      Positioned(
                        top: -((OBAvatar.AVATAR_SIZE_EXTRA_LARGE / 2)) - 10,
                        left: 18,
                        child: StreamBuilder(
                            stream: _user.updateSubject,
                            initialData: _user,
                            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                              var user = snapshot.data;

                              return OBAvatar(
                                borderWidth: 3,
                                avatarUrl: user?.getProfileAvatar(),
                                size: OBAvatarSize.extraLarge,
                                isZoomable: true,
                              );
                            }),
                      ),
                    ],
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Community>> _getJoinedCommunities() async {
    CommunitiesList joinedCommunitiesList =
        await _userService.getJoinedCommunities();
    return joinedCommunitiesList.communities;
  }

  Widget _buildNameRow(
      {@required User user,
      @required BuildContext context,
      @required ToastService toastService}) {
    if (user.hasProfileBadges() && user.getProfileBadges().length > 0) {
      return Row(children: <Widget>[
        OBProfileName(user),
        _getUserBadge(user: user, toastService: toastService, context: context)
      ]);
    }
    return OBProfileName(user);
  }

  Widget _getUserBadge(
      {@required User user,
      @required ToastService toastService,
      @required BuildContext context}) {
    Badge badge = user.getProfileBadges()[0];
    return GestureDetector(
      onTap: () {
        toastService.info(
            message: _getUserBadgeDescription(user), context: context);
      },
      child: OBUserBadge(badge: badge, size: OBUserBadgeSize.small),
    );
  }

  String _getUserBadgeDescription(User user) {
    Badge badge = user.getProfileBadges()[0];
    return badge.getKeywordDescription();
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