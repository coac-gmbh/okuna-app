import 'package:Openbook/models/follows_list.dart';
import 'package:Openbook/pages/home/pages/menu/pages/follows_lists/widgets/follows_list_tile.dart';
import 'package:Openbook/services/modal_service.dart';
import 'package:Openbook/widgets/buttons/accent_button.dart';
import 'package:Openbook/widgets/icon.dart';
import 'package:Openbook/widgets/icon_button.dart';
import 'package:Openbook/widgets/nav_bars/themed_nav_bar.dart';
import 'package:Openbook/widgets/page_scaffold.dart';
import 'package:Openbook/provider.dart';
import 'package:Openbook/services/toast.dart';
import 'package:Openbook/services/user.dart';
import 'package:Openbook/widgets/search_bar.dart';
import 'package:Openbook/widgets/theming/primary_color_container.dart';
import 'package:Openbook/widgets/theming/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Openbook/services/httpie.dart';

class OBFollowsListsPage extends StatefulWidget {
  @override
  State<OBFollowsListsPage> createState() {
    return OBFollowsListsPageState();
  }
}

class OBFollowsListsPageState extends State<OBFollowsListsPage> {
  UserService _userService;
  ToastService _toastService;
  ModalService _modalService;

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  ScrollController _followsListsScrollController;
  List<FollowsList> _followsLists = [];
  List<FollowsList> _followsListsSearchResults = [];

  String _searchQuery;

  bool _needsBootstrap;

  @override
  void initState() {
    super.initState();
    _followsListsScrollController = ScrollController();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    _needsBootstrap = true;
    _followsLists = [];
  }

  @override
  Widget build(BuildContext context) {
    if (_needsBootstrap) {
      var provider = OpenbookProvider.of(context);
      _userService = provider.userService;
      _toastService = provider.toastService;
      _modalService = provider.modalService;

      _bootstrap();
      _needsBootstrap = false;
    }

    return OBCupertinoPageScaffold(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        navigationBar: OBThemedNavigationBar(
          title: 'My lists',
          trailing: OBIconButton(
            OBIcons.add,
            themeColor: OBIconThemeColor.primaryAccent,
            onPressed: _onWantsToCreateList,
          ),
        ),
        child: Stack(
          children: <Widget>[
            OBPrimaryColorContainer(
                child: Column(
              children: <Widget>[
                SizedBox(
                    child: OBSearchBar(
                  onSearch: _onSearch,
                  hintText: 'Search for a list...',
                )),
                Expanded(
                  child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          controller: _followsListsScrollController,
                          padding: EdgeInsets.all(0),
                          itemCount: _followsListsSearchResults.length + 1,
                          itemBuilder: (context, index) {

                            if (index ==
                                _followsListsSearchResults.length) {
                              if (_followsListsSearchResults.isEmpty) {
                                // Results were empty
                                return ListTile(
                                    leading: OBIcon(OBIcons.sad),
                                    title: OBText(
                                        'No list found for "$_searchQuery"'));
                              } else {
                                return const SizedBox();
                              }
                            }

                            var followsList = _followsListsSearchResults[index];

                            var onFollowsListDeletedCallback = () {
                              _removeFollowsList(followsList);
                            };

                            return OBFollowsListTile(
                              followsList: followsList,
                              onFollowsListDeletedCallback:
                                  onFollowsListDeletedCallback,
                            );
                          }),
                      onRefresh: _refreshComments),
                ),
              ],
            )),
          ],
        ));
  }

  void _bootstrap() async {
    await _refreshComments();
  }

  Future<void> _refreshComments() async {
    try {
      _followsLists = (await _userService.getFollowsLists()).lists;
      _setFollowsLists(_followsLists);
      _scrollToTop();
    } on HttpieConnectionRefusedError {
      _toastService.error(message: 'No internet connection', context: context);
    } catch (error) {
      _toastService.error(message: 'Unknown error', context: context);
      rethrow;
    }
  }

  void _onWantsToCreateList() async {
    FollowsList createdFollowsList =
        await _modalService.openCreateFollowsList(context: context);
    if (createdFollowsList != null) {
      _onFollowsListCreated(createdFollowsList);
    }
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      _resetFollowsListsSearchResults();
      _setSearchQuery(null);
      return;
    }

    _setSearchQuery(query);
    String uppercaseQuery = query.toUpperCase();
    var searchResults = _followsLists.where((followsList) {
      return followsList.name.toUpperCase().contains(uppercaseQuery);
    }).toList();

    _setFollowsListsSearchResults(searchResults);
  }

  void _resetFollowsListsSearchResults() {
    _setFollowsListsSearchResults(_followsLists.toList());
  }

  void _setFollowsListsSearchResults(
      List<FollowsList> followsListsSearchResults) {
    setState(() {
      _followsListsSearchResults = followsListsSearchResults;
    });
  }

  void _removeFollowsList(FollowsList followsList) {
    setState(() {
      _followsLists.remove(followsList);
      _followsListsSearchResults.remove(followsList);
    });
  }

  void _onFollowsListCreated(FollowsList createdFollowsList) {
    this._followsLists.insert(0, createdFollowsList);
    this._setFollowsLists(this._followsLists.toList());
    _scrollToTop();
  }

  void _scrollToTop() {
    _followsListsScrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _setFollowsLists(List<FollowsList> followsLists) {
    setState(() {
      this._followsLists = followsLists;
      _resetFollowsListsSearchResults();
    });
  }

  void _setSearchQuery(String searchQuery) {
    setState(() {
      _searchQuery = searchQuery;
    });
  }
}

typedef Future<FollowsList> OnWantsToCreateFollowsList();
typedef Future<FollowsList> OnWantsToEditFollowsList(FollowsList followsList);
typedef void OnWantsToSeeFollowsList(FollowsList followsList);