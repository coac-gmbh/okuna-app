import 'dart:async';
import 'dart:io';

import 'package:Okuna/models/circle.dart';
import 'package:Okuna/models/follows_list.dart';
import 'package:Okuna/models/post.dart';
import 'package:Okuna/models/user.dart';
import 'package:Okuna/pages/home/lib/poppable_page_controller.dart';
import 'package:Okuna/pages/home/pages/notifications/notifications.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/localization.dart';
import 'package:Okuna/services/modal_service.dart';
import 'package:Okuna/services/theme.dart';
import 'package:Okuna/services/theme_value_parser.dart';
import 'package:Okuna/services/user.dart';
import 'package:Okuna/widgets/badges/badge.dart';
import 'package:Okuna/widgets/buttons/button.dart';
import 'package:Okuna/widgets/buttons/floating_action_button.dart';
import 'package:Okuna/widgets/icon.dart';
import 'package:Okuna/widgets/icon_button.dart';
import 'package:Okuna/widgets/nav_bars/themed_nav_bar.dart';
import 'package:Okuna/widgets/page_scaffold.dart';
import 'package:Okuna/widgets/new_post_data_uploader.dart';
import 'package:Okuna/widgets/posts_stream/posts_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OBTimelinePage extends StatefulWidget {
  final OBTimelinePageController controller;

  OBTimelinePage({
    @required this.controller,
  });

  @override
  OBTimelinePageState createState() {
    return OBTimelinePageState();
  }
}

class OBTimelinePageState extends State<OBTimelinePage>
    with TickerProviderStateMixin {
  OBPostsStreamController _timelinePostsStreamController;
  ScrollController _timelinePostsStreamScrollController;
  ModalService _modalService;
  UserService _userService;
  LocalizationService _localizationService;
  ThemeService _themeService;
  ThemeValueParserService _themeValueParserService;

  List<Post> _initialPosts;
  List<OBNewPostData> _newPostsData;
  List<Circle> _filteredCircles;
  List<FollowsList> _filteredFollowsLists;

  StreamSubscription _loggedInUserChangeSubscription;

  bool _needsBootstrap;
  bool _loggedInUserBootstrapped;

  double _hideFloatingButtonTolerance = 10;
  AnimationController _hideFloatingButtonAnimation;
  double _previousScrollPixels;


  OBNotificationsPageController _notificationsPageController;
  int _loggedInUserUnreadNotifications;

  @override
  void initState() {
    super.initState();
    _timelinePostsStreamController = OBPostsStreamController();
    _timelinePostsStreamScrollController = ScrollController();
    _notificationsPageController = OBNotificationsPageController();
    widget.controller.attach(context: context, state: this);
    _needsBootstrap = true;
    _loggedInUserUnreadNotifications = 0;
    _loggedInUserBootstrapped = false;
    _filteredCircles = [];
    _filteredFollowsLists = [];
    _newPostsData = [];
    _hideFloatingButtonAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFloatingButtonAnimation.forward();

    _previousScrollPixels = 0;
    //_getLoggedInNotifications();

    _timelinePostsStreamScrollController.addListener(() {
      double newScrollPixelPosition =
          _timelinePostsStreamScrollController.position.pixels;
      double scrollPixelDifference =
          _previousScrollPixels - newScrollPixelPosition;

      if (_timelinePostsStreamScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollPixelDifference * -1 > _hideFloatingButtonTolerance) {
          _hideFloatingButtonAnimation.reverse();
        }
      } else {
        if (scrollPixelDifference > _hideFloatingButtonTolerance) {
          _hideFloatingButtonAnimation.forward();
        }
      }

      _previousScrollPixels = newScrollPixelPosition;
    });

  }

  @override
  void dispose() {
    _hideFloatingButtonAnimation.dispose();
    super.dispose();
    _loggedInUserChangeSubscription.cancel();
  }

  void _bootstrap() async {
    _loggedInUserChangeSubscription =
        _userService.loggedInUserChange.listen(_onLoggedInUserChange);
  }

  @override
  Widget build(BuildContext context) {

    var openbookProvider = OpenbookProvider.of(context);
    var navigationService = openbookProvider.navigationService;

    if (_needsBootstrap) {
      var openbookProvider = OpenbookProvider.of(context);
      _modalService = openbookProvider.modalService;
      _localizationService = openbookProvider.localizationService;
      _userService = openbookProvider.userService;
      _themeService = openbookProvider.themeService;
      _themeService = openbookProvider.themeService;
      _themeValueParserService = openbookProvider.themeValueParserService;
      _bootstrap();
      _needsBootstrap = false;
    }

  Widget _buildNotificationsButton(){
    return Stack(
            clipBehavior: Clip.none, children: <Widget>[
              OBIconButton(
          OBIcons.notifications,
          themeColor: OBIconThemeColor.primaryAccent,
          onPressed: () async{
            await navigationService.navigateToNotifications(
                                context: context, controller: _notificationsPageController);
            _resetLoggedInUserUnreadNotificationsCount();                    
          },
        ),
              _loggedInUserUnreadNotifications != null
                  && _loggedInUserUnreadNotifications > 0 ? Positioned(
                      right: -8,
                      child: OBBadge(
                        size: 10,
                      ),
                    )
                  : const SizedBox()
            ],
          );
  }

    return OBCupertinoPageScaffold(
        backgroundColor: _themeValueParserService
            .parseColor(_themeService.getActiveTheme().primaryColor),
        navigationBar: OBThemedNavigationBar(
            title: 'Home', 
            trailing: _buildNotificationsButton(),
            leading:  _buildFiltersButton(),
          ),
        child: Stack(
          children: <Widget>[
            _loggedInUserBootstrapped
                ? OBPostsStream(
                    controller: _timelinePostsStreamController,
                    scrollController: _timelinePostsStreamScrollController,
                    prependedItems: _buildPostsStreamPrependedItems(),
                    streamIdentifier: 'timeline',
                    onScrollLoader: _postsStreamOnScrollLoader,
                    refresher: _postsStreamRefresher,
                    initialPosts: _initialPosts,
                  )
                : const SizedBox(),
            Positioned(
                bottom: 20.0,
                right: 20.0,
                child: Semantics(
                    button: true,
                    label: _localizationService.post__create_new_post_label,
                    child: ScaleTransition(
                        scale: _hideFloatingButtonAnimation,
                        child: OBFloatingActionButton(
                            type: OBButtonType.primary,
                            onPressed: _onCreatePost,
                            child: const OBIcon(OBIcons.createPost,
                                size: OBIconSize.large, color: Colors.white)))))
          ],
        ));

        
  }

  List<Widget> _buildPostsStreamPrependedItems() {
    return _buildNewPostDataUploaders();
  }

  List<Widget> _buildNewPostDataUploaders() {
    return _newPostsData.map(_buildNewPostDataUploader).toList();
  }

  Widget _buildNewPostDataUploader(OBNewPostData newPostData) {
    return OBNewPostDataUploader(
      key: Key(newPostData.getUniqueKey()),
      data: newPostData,
      onPostPublished: _onNewPostDataUploaderPostPublished,
      onCancelled: _onNewPostDataUploaderCancelled,
    );
  }

  Widget _buildFiltersButton() {
    int filtersCount = countFilters();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OBBadge(
          count: filtersCount,
        ),
        const SizedBox(
          width: 10,
        ),
        OBIconButton(
          OBIcons.filter,
          themeColor: OBIconThemeColor.primaryAccent,
          onPressed: _onWantsFilters,
        )
      ],
    );
  }

  void _setUnreadNotifications(int unreadNotifications) {
    setState(() {
      _loggedInUserUnreadNotifications = unreadNotifications;
    });
  }

  void _resetLoggedInUserUnreadNotificationsCount() {
    print('here');
    User loggedInUser = _userService.getLoggedInUser();
    if (loggedInUser != null) {
    print('here2');
      loggedInUser.resetUnreadNotificationsCount();
      _setUnreadNotifications(loggedInUser.unreadNotificationsCount);
    }
  }

  void _getLoggedInNotifications(){
    User loggedInUser = _userService.getLoggedInUser();
    if (loggedInUser != null) {
      _setUnreadNotifications(loggedInUser.unreadNotificationsCount);
    }
  }

  void _onLoggedInUserChange(User newUser) async {
    if (newUser == null) return;
    List<Post> initialPosts = (await _userService.getStoredFirstPosts()).posts;
    _setUnreadNotifications(newUser.unreadNotificationsCount);
    setState(() {
      _loggedInUserBootstrapped = true;
      _initialPosts = initialPosts;
      _loggedInUserChangeSubscription.cancel();
    });
  }

  Future<List<Post>> _postsStreamRefresher() async {
    bool cachePosts = _filteredCircles.isEmpty && _filteredFollowsLists.isEmpty;

    List<Post> posts = (await _userService.getTimelinePosts(
            count: 10,
            circles: _filteredCircles,
            followsLists: _filteredFollowsLists,
            cachePosts: cachePosts))
        .posts;

    return posts;
  }

  Future<List<Post>> _postsStreamOnScrollLoader(List<Post> posts) async {
    Post lastPost = posts.last;
    int lastPostId = lastPost.id;

    List<Post> morePosts = (await _userService.getTimelinePosts(
            maxId: lastPostId,
            circles: _filteredCircles,
            count: 10,
            followsLists: _filteredFollowsLists))
        .posts;

    return morePosts;
  }

  Future<bool> _onCreatePost({String text, File image, File video}) async {
    OBNewPostData createPostData = await _modalService.openCreatePost(
        text: text, image: image, video: video, context: context);
    if (createPostData != null) {
      addNewPostData(createPostData);
      _timelinePostsStreamController.scrollToTop(skipRefresh: true);

      return true;
    }

    return false;
  }

  Future<void> setFilters(
      {List<Circle> circles, List<FollowsList> followsLists}) async {
    _filteredCircles = circles;
    _filteredFollowsLists = followsLists;
    return _timelinePostsStreamController.refreshPosts();
  }

  Future<void> clearFilters() {
    _filteredCircles = [];
    _filteredFollowsLists = [];
    return _timelinePostsStreamController.refreshPosts();
  }

  List<Circle> getFilteredCircles() {
    return _filteredCircles.toList();
  }

  List<FollowsList> getFilteredFollowsLists() {
    return _filteredFollowsLists.toList();
  }

  int countFilters() {
    return _filteredCircles.length + _filteredFollowsLists.length;
  }

  void _onNewPostDataUploaderCancelled(OBNewPostData newPostData) {
    _removeNewPostData(newPostData);
  }

  void _onNewPostDataUploaderPostPublished(
      Post publishedPost, OBNewPostData newPostData) {
    _timelinePostsStreamController.addPostToTop(publishedPost);
    _removeNewPostData(newPostData);
  }

  void addNewPostData(OBNewPostData postUploaderData) {
    setState(() {
      this._newPostsData.insert(0, postUploaderData);
    });
  }

  void _removeNewPostData(OBNewPostData postUploaderData) {
    setState(() {
      this._newPostsData.remove(postUploaderData);
    });
  }

  void scrollToTop() {
    _timelinePostsStreamController.scrollToTop();
  }

  void _onWantsFilters() {
    _modalService.openTimelineFilters(
        timelineController: widget.controller, context: context);
  }
}

class OBTimelinePageController extends PoppablePageController {
  OBTimelinePageState _state;

  void attach({@required BuildContext context, OBTimelinePageState state}) {
    super.attach(context: context);
    _state = state;
  }

  Future<void> setPostFilters(
      {List<Circle> circles, List<FollowsList> followsLists}) async {
    return _state.setFilters(circles: circles, followsLists: followsLists);
  }

  Future<void> clearPostFilters(
      {List<Circle> circles, List<FollowsList> followsLists}) async {
    return _state.setFilters(circles: circles, followsLists: followsLists);
  }

  List<Circle> getFilteredCircles() {
    return _state.getFilteredCircles();
  }

  List<FollowsList> getFilteredFollowsLists() {
    return _state.getFilteredFollowsLists();
  }

  Future<bool> createPost({String text, File image, File video}) {
    return _state._onCreatePost(text: text, image: image, video: video);
  }

  void scrollToTop() {
    _state.scrollToTop();
  }
}
