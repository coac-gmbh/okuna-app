import 'dart:io';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/ConversationModel.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/chat/ChatScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConversationsScreen extends StatefulWidget {
  final User user;

  const ConversationsScreen({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _ConversationsState();
  }
}

class _ConversationsState extends State<ConversationsScreen> {
  User user;
  final fireStoreUtils = FireStoreUtils();
  Future<List<User>> _matchesFuture;
  Stream<List<HomeConversationModel>> _conversationsStream;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    fireStoreUtils.getBlocks().listen((shouldRefresh) {
      if (shouldRefresh) {
        setState(() {});
      }
    });
    _matchesFuture = fireStoreUtils.getMatchedUserObject(user.userID);
    _conversationsStream = fireStoreUtils.getConversations(user.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 100,
            child: FutureBuilder<List<User>>(
              future: _matchesFuture,
              initialData: [],
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting)
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
                      ),
                    ),
                  );
                if (!snap.hasData || (snap.data?.isEmpty ?? true)) {
                  return Center(
                    child: Text(
                      'No Matches found.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      User friend = snap.data[index];
                      return fireStoreUtils.validateIfUserBlocked(friend.userID)
                          ? Container(
                              width: 0,
                              height: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 4, right: 4),
                              child: InkWell(
                                onLongPress: () => _onMatchLongPress(friend),
                                onTap: () async {
                                  String channelID;
                                  if (friend.userID.compareTo(user.userID) <
                                      0) {
                                    channelID = friend.userID + user.userID;
                                  } else {
                                    channelID = user.userID + friend.userID;
                                  }
                                  ConversationModel conversationModel =
                                      await fireStoreUtils
                                          .getChannelByIdOrNull(channelID);
                                  push(
                                      context,
                                      ChatScreen(
                                          homeConversationModel:
                                              HomeConversationModel(
                                                  isGroupChat: false,
                                                  members: [friend],
                                                  conversationModel:
                                                      conversationModel)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    displayCircleImage(
                                        friend.profilePictureURL, 50, false),
                                    Expanded(
                                      child: Container(
                                        width: 75,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            '${friend.firstName}',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  );
                }
              },
            ),
          ),
          StreamBuilder<List<HomeConversationModel>>(
            stream: _conversationsStream,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(COLOR_ACCENT)),
                    ),
                  ),
                );
              } else if (!snapshot.hasData ||
                  (snapshot.data?.isEmpty ?? true)) {
                return Center(
                  child: Text(
                    'No Conversations found.',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final homeConversationModel = snapshot.data[index];
                      if (homeConversationModel.isGroupChat) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 8, bottom: 8),
                          child: _buildConversationRow(homeConversationModel),
                        );
                      } else {
                        return fireStoreUtils.validateIfUserBlocked(
                                homeConversationModel.members.first.userID)
                            ? Container(
                                width: 0,
                                height: 0,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16, top: 8, bottom: 8),
                                child: _buildConversationRow(
                                    homeConversationModel),
                              );
                      }
                    });
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildConversationRow(HomeConversationModel homeConversationModel) {
    String user1Image = '';
    String user2Image = '';
    if (homeConversationModel.members.length >= 2) {
      user1Image = homeConversationModel.members.first.profilePictureURL;
      user2Image = homeConversationModel.members.elementAt(1).profilePictureURL;
    }
    return homeConversationModel.isGroupChat
        ? Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 12.8),
            child: InkWell(
              onTap: () {
                push(context,
                    ChatScreen(homeConversationModel: homeConversationModel));
              },
              child: Row(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      displayCircleImage(user1Image, 44, false),
                      Positioned(
                          left: -16,
                          bottom: -12.8,
                          child: displayCircleImage(user2Image, 44, true))
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, right: 8, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${homeConversationModel.conversationModel.name}',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontFamily: Platform.isIOS ? 'sanFran' : 'Roboto',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${homeConversationModel.conversationModel.lastMessage} • ${formatTimestamp(homeConversationModel.conversationModel.lastMessageDate.seconds)}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffACACAC)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              push(context,
                  ChatScreen(homeConversationModel: homeConversationModel));
            },
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    displayCircleImage(
                        homeConversationModel.members.first.profilePictureURL,
                        60,
                        false),
                    Positioned(
                        right: 2.4,
                        bottom: 2.4,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              color: homeConversationModel.members.first.active
                                  ? Colors.green
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1.6)),
                        ))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${homeConversationModel.members.first.fullName()}',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontFamily:
                                  Platform.isIOS ? 'sanFran' : 'Roboto'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${homeConversationModel.conversationModel?.lastMessage} • ${formatTimestamp(homeConversationModel.conversationModel.lastMessageDate.seconds ?? 0)}',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xffACACAC)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  _onMatchLongPress(User friend) {
    final action = CupertinoActionSheet(
      message: Text(
        friend.fullName(),
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("View Profile"),
          isDefaultAction: true,
          onPressed: () async {
            Navigator.maybePop(context);
            // TODO: Get user by id
            // push(context, OBProfilePage(user));
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }
}
