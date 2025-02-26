import 'dart:async';
import 'dart:io';

import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/models/push_notification.dart';
import 'package:Okuna/pages/home/lib/poppable_page_controller.dart';
import 'package:Okuna/services/intercom.dart';
import 'package:Okuna/services/push_notifications/push_notifications.dart';
import 'package:Okuna/models/user.dart';
import 'package:Okuna/pages/home/pages/communities/communities.dart';
import 'package:Okuna/pages/home/pages/own_profile.dart';
import 'package:Okuna/pages/home/pages/timeline/timeline.dart';
import 'package:Okuna/pages/home/pages/menu/menu.dart';
import 'package:Okuna/pages/home/pages/search/search.dart';
import 'package:Okuna/pages/home/widgets/bottom-tab-bar.dart';
import 'package:Okuna/pages/home/widgets/own_profile_active_icon.dart';
import 'package:Okuna/pages/home/widgets/tab-scaffold.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/httpie.dart';
import 'package:Okuna/services/modal_service.dart';
import 'package:Okuna/services/share.dart';
import 'package:Okuna/services/toast.dart';
import 'package:Okuna/services/user.dart';
import 'package:Okuna/translation/constants.dart';
import 'package:Okuna/widgets/avatars/avatar.dart';
import 'package:Okuna/widgets/icon.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OBHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OBHomePageState();
  }
}

class OBHomePageState extends State<OBHomePage>
    with WidgetsBindingObserver {
  static const String oneSignalAppId = '66074bf4-9943-4504-a011-531c2635698b';
  UserService _userService;
  ToastService _toastService;
  PushNotificationsService _pushNotificationsService;
  IntercomService _intercomService;
  ModalService _modalService;
  ShareService _shareService;

  int _currentIndex;
  int _lastIndex;
  bool _needsBootstrap;

  StreamSubscription _loggedInUserChangeSubscription;
  StreamSubscription _loggedInUserUpdateSubscription;
  StreamSubscription _pushNotificationOpenedSubscription;
  StreamSubscription _pushNotificationSubscription;

  OBTimelinePageController _timelinePageController;
  OBOwnProfilePageController _ownProfilePageController;
  OBMainSearchPageController _searchPageController;
  OBMainMenuPageController _mainMenuPageController;
  OBCommunitiesPageController _communitiesPageController;
  OBHomeScreenController _homeScreenController;

  String _loggedInUserAvatarUrl;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_backButtonInterceptor);
    WidgetsBinding.instance.addObserver(this);
    _needsBootstrap = true;
    _lastIndex = 0;
    _currentIndex = 0;
    _timelinePageController = OBTimelinePageController();
    _ownProfilePageController = OBOwnProfilePageController();
    _searchPageController = OBMainSearchPageController();
    _mainMenuPageController = OBMainMenuPageController();
    _communitiesPageController = OBCommunitiesPageController();
    _homeScreenController = OBHomeScreenController();
  }

  @override
  void dispose() {
    super.dispose();
    BackButtonInterceptor.remove(_backButtonInterceptor);
    WidgetsBinding.instance.removeObserver(this);
    _loggedInUserChangeSubscription.cancel();
    if (_loggedInUserUpdateSubscription != null)
      _loggedInUserUpdateSubscription.cancel();
    if (_pushNotificationOpenedSubscription != null) {
      _pushNotificationOpenedSubscription.cancel();
    }
    if (_pushNotificationSubscription != null) {
      _pushNotificationSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_needsBootstrap) {
      var openbookProvider = OpenbookProvider.of(context);
      _userService = openbookProvider.userService;
      _pushNotificationsService = openbookProvider.pushNotificationsService;
      _intercomService = openbookProvider.intercomService;
      _toastService = openbookProvider.toastService;
      _modalService = openbookProvider.modalService;
      _shareService = openbookProvider.shareService;
      _bootstrap();
      _needsBootstrap = false;
    }

    return Material(
      child: OBCupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _getPageForTabIndex(index);
            },
          );
        },
        tabBar: _createTabBar(),
      ),
    );
  }

  Widget _getPageForTabIndex(int index) {
    Widget page;
    switch (OBHomePageTabs.values[index]) {
      case OBHomePageTabs.timeline:
        page = OBTimelinePage(
          controller: _timelinePageController,
        );
        break;
      case OBHomePageTabs.search:
        page = OBMainSearchPage(
          controller: _searchPageController,
        );
        break;
      case OBHomePageTabs.home:
        page = HomeScreen();
        break;
      case OBHomePageTabs.communities:
        page = OBMainCommunitiesPage(
          controller: _communitiesPageController,
        );
        break;
      case OBHomePageTabs.profile:
        page = OBOwnProfilePage(controller: _ownProfilePageController);
        break;
      case OBHomePageTabs.menu:
        page = OBMainMenuPage(
          controller: _mainMenuPageController,
        );
        break;
      default:
        throw 'Unhandled index';
    }

    return page;
  }

  Widget _createTabBar() {
    return OBCupertinoTabBar(
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: (int index) {
        var tappedTab = OBHomePageTabs.values[index];
        var currentTab = OBHomePageTabs.values[_lastIndex];

        if (tappedTab == OBHomePageTabs.timeline &&
            currentTab == OBHomePageTabs.timeline) {
          if (_timelinePageController.isFirstRoute()) {
            _timelinePageController.scrollToTop();
          } else {
            _timelinePageController.popUntilFirstRoute();
          }
        }

        if (tappedTab == OBHomePageTabs.profile &&
            currentTab == OBHomePageTabs.profile) {
          if (_ownProfilePageController.isFirstRoute()) {
            _ownProfilePageController.scrollToTop();
          } else {
            _ownProfilePageController.popUntilFirstRoute();
          }
        }

        if (tappedTab == OBHomePageTabs.communities &&
            currentTab == OBHomePageTabs.communities) {
          if (_communitiesPageController.isFirstRoute()) {
            _communitiesPageController.scrollToTop();
          } else {
            _communitiesPageController.popUntilFirstRoute();
          }
        }

        if (tappedTab == OBHomePageTabs.search &&
            currentTab == OBHomePageTabs.search) {
          if (_searchPageController.isFirstRoute()) {
            _searchPageController.scrollToTop();
          } else {
            _searchPageController.popUntilFirstRoute();
          }
        }

        if (tappedTab == OBHomePageTabs.home &&
            currentTab == OBHomePageTabs.home) {
          _homeScreenController.popUntilFirstRoute();
        }
        if (tappedTab == OBHomePageTabs.menu &&
            currentTab == OBHomePageTabs.menu) {
          _mainMenuPageController.popUntilFirstRoute();
        }

        _lastIndex = index;
        return true;
      },
      items: [
        BottomNavigationBarItem(
          title: const SizedBox(),
          icon: const OBIcon(OBIcons.home),
          activeIcon: const OBIcon(
            OBIcons.home,
            themeColor: OBIconThemeColor.primaryAccent,
          ),
        ),
        BottomNavigationBarItem(
          title: const SizedBox(),
          icon: const OBIcon(OBIcons.search),
          activeIcon: const OBIcon(
            OBIcons.search,
            themeColor: OBIconThemeColor.primaryAccent,
          ),
        ),
        BottomNavigationBarItem(
          title: const SizedBox(),
          icon: const OBIcon(OBIcons.communities),
          activeIcon: const OBIcon(
            OBIcons.communities,
            themeColor: OBIconThemeColor.primaryAccent,
          ),
        ),
        BottomNavigationBarItem(
            title: const SizedBox(),
          icon: const OBIcon(OBIcons.matchmaking),
          activeIcon: const OBIcon(
            OBIcons.matchmaking,
            themeColor: OBIconThemeColor.primaryAccent,
          ),),
        BottomNavigationBarItem(
            title: const SizedBox(),
            icon: OBAvatar(
              avatarUrl: _loggedInUserAvatarUrl,
              size: OBAvatarSize.extraSmall,
            ),
            activeIcon: OBOwnProfileActiveIcon(
              avatarUrl: _loggedInUserAvatarUrl,
              size: OBAvatarSize.extraSmall,
            )),
        BottomNavigationBarItem(
          title: const SizedBox(),
          icon: const OBIcon(OBIcons.menu),
          activeIcon: const OBIcon(
            OBIcons.menu,
            themeColor: OBIconThemeColor.primaryAccent,
          ),
        ),
      ],
    );
  }

  void _bootstrap() async {
    _loggedInUserChangeSubscription =
        _userService.loggedInUserChange.listen(_onLoggedInUserChange);

    if (!_userService.isLoggedIn()) {
      try {
        await _userService.loginWithStoredUserData();
      } catch (error) {
        if (error is AuthTokenMissingError) {
          _logout();
        } else if (error is HttpieRequestError) {
          HttpieResponse response = error.response;
          if (response.isForbidden() || response.isUnauthorized()) {
            _logout(unsubscribePushNotifications: true);
          } else {
            _onError(error);
          }
        } else {
          _onError(error);
        }
      }
    }

    _shareService.subscribe(_onShare);
  }

  Future _logout({unsubscribePushNotifications = false}) async {
    try {
      if (unsubscribePushNotifications)
        await _pushNotificationsService.unsubscribeFromPushNotifications();
    } catch (error) {
      throw error;
    } finally {
      await _userService.logout();
    }
  }

  bool _backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    OBHomePageTabs currentTab = OBHomePageTabs.values[_lastIndex];
    PoppablePageController currentTabController;

    switch (currentTab) {
      case OBHomePageTabs.home:
        currentTabController = _homeScreenController;
        break;
      case OBHomePageTabs.communities:
        currentTabController = _communitiesPageController;
        break;
      case OBHomePageTabs.timeline:
        currentTabController = _timelinePageController;
        break;
      case OBHomePageTabs.menu:
        currentTabController = _mainMenuPageController;
        break;
      case OBHomePageTabs.search:
        currentTabController = _searchPageController;
        break;
      case OBHomePageTabs.profile:
        currentTabController = _ownProfilePageController;
        break;
      default:
        throw 'No tab controller to pop';
    }

    bool canPopRootRoute = Navigator.of(context, rootNavigator: true).canPop();
    bool canPopRoute = currentTabController.canPop();
    bool preventCloseApp = false;

    if (canPopRoute && !canPopRootRoute) {
      currentTabController.pop();
      // Stop default
      preventCloseApp = true;
    }

    // Close the app
    return preventCloseApp;
  }

  void _onLoggedInUserChange(User newUser) async {
    if (newUser == null) {
      Navigator.pushReplacementNamed(context, '/auth');
    } else {
      _pushNotificationsService.bootstrap();
      _intercomService.enableIntercom();

      _loggedInUserUpdateSubscription =
          newUser.updateSubject.listen(_onLoggedInUserUpdate);

      _pushNotificationOpenedSubscription = _pushNotificationsService
          .pushNotificationOpened
          .listen(_onPushNotificationOpened);

      _pushNotificationSubscription = _pushNotificationsService.pushNotification
          .listen(_onPushNotification);

      if (newUser.areGuidelinesAccepted != null &&
          !newUser.areGuidelinesAccepted) {
        _modalService.openAcceptGuidelines(context: context);
      }

      if (newUser.language == null || !supportedLanguages.contains(newUser.language.code)) {
        _userService.setLanguageFromDefaults();
      }
      _userService.checkAndClearTempDirectories();
    }
  }

  void _onPushNotification(PushNotification pushNotification) {
      User loggedInUser = _userService.getLoggedInUser();
      if (loggedInUser != null) {
        loggedInUser.incrementUnreadNotificationsCount();
      }
  }

  void _onPushNotificationOpened(
      PushNotificationOpenedResult pushNotificationOpenedResult) {
    _navigateToTab(OBHomePageTabs.timeline);
  }

  Future<bool> _onShare({String text, File image, File video}) async {
    bool postCreated = await _timelinePageController.createPost(
        text: text, image: image, video: video);

    if (postCreated) {
      _timelinePageController.popUntilFirstRoute();
      _navigateToTab(OBHomePageTabs.timeline);
    }

    return true;
  }

  void _navigateToTab(OBHomePageTabs tab) {
    int newIndex = OBHomePageTabs.values.indexOf(tab);
    // This only works once... bug with flutter.
    // Reported it here https://github.com/flutter/flutter/issues/28992
    _setCurrentIndex(newIndex);
  }

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      bool hasAuthToken = await _userService.hasAuthToken();
      if (hasAuthToken) _userService.refreshUser();
    }
  }

  void _onLoggedInUserUpdate(User user) {
    _setAvatarUrl(user.getProfileAvatar());
  }

  void _setAvatarUrl(String avatarUrl) {
    setState(() {
      _loggedInUserAvatarUrl = avatarUrl;
    });
  }

  void _onError(error) async {
    if (error is HttpieConnectionRefusedError) {
      _toastService.error(
          message: error.toHumanReadableMessage(), context: context);
    } else if (error is HttpieRequestError) {
      String errorMessage = await error.toHumanReadableMessage();
      _toastService.error(message: errorMessage, context: context);
    } else {
      _toastService.error(message: 'Unknown error', context: context);
      throw error;
    }
  }
}

enum OBHomePageTabs {
  timeline,
  search,
  communities,
  home,
  profile,
  menu
}
