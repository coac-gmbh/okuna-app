import 'dart:async';
import 'dart:io';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/ChatModel.dart';
import 'package:Okuna/matchmaking/model/ChatVideoContainer.dart';
import 'package:Okuna/matchmaking/model/ConversationModel.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/model/MessageData.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/matchmaking/pages/chat/FullScreenImageViewer.dart';
import 'package:Okuna/matchmaking/pages/chat/PlayerWidget.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
enum RecordingState { HIDDEN, VISIBLE, Recording }

class ChatScreen extends StatefulWidget {
  final HomeConversationModel homeConversationModel;

  const ChatScreen({Key key, @required this.homeConversationModel})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  HomeConversationModel homeConversationModel;
  TextEditingController _messageController = new TextEditingController();
  final FireStoreUtils _fireStoreUtils = FireStoreUtils();
  TextEditingController _groupNameController = TextEditingController();
  RecordingState currentRecordingState = RecordingState.HIDDEN;
  Timer audioMessageTimer;
  String audioMessageTime = 'Start Recording';

  String tempPathForAudioMessages;
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();

  Stream<ChatModel> chatStream;

  bool _mRecorderIsInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();

    homeConversationModel = widget.homeConversationModel;
    if (homeConversationModel.isGroupChat)
      _groupNameController.text =
          homeConversationModel.conversationModel?.name ?? '';
    
    setupStream();
    
  }

  void _checkPermission() async {
    if(await Permission.microphone.status.isDenied){
      if (await Permission.microphone.request().isGranted) {
        PermissionStatus status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          throw RecordingPermissionException("Microphone permission not granted");
        }
      }
    }

    if(await Permission.microphone.status.isGranted){
      _loadMicrophone();  
    }
  }

  void _loadMicrophone(){
    _myRecorder.openAudioSession().then((value) {
      setState(() {
        _mRecorderIsInitialized = true;
      });
    });
  }

  setupStream() {
    chatStream = _fireStoreUtils
        .getChatMessages(homeConversationModel)
        .asBroadcastStream();
    chatStream.listen((chatModel) {
      if (mounted) {
        homeConversationModel.members = chatModel.members;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          CALLS_ENABLED
              ? IconButton(
                  tooltip: 'Voice call',
                  iconSize: 20,
                  constraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
                  icon: Icon(Icons.call),
                  onPressed: () {
                    // TODO:
                    // homeConversationModel.isGroupChat
                    //     ? push(
                    //         context,
                    //         VoiceCallsGroupScreen(
                    //           isCaller: true,
                    //           homeConversationModel: homeConversationModel,
                    //           sessionDescription: null,
                    //           sessionType: null,
                    //           caller: HomeScreenState.currentUser,
                    //         ))
                    //     : push(
                    //         context,
                    //         VoiceCallScreen(
                    //           isCaller: true,
                    //           homeConversationModel: homeConversationModel,
                    //           sessionDescription: null,
                    //           sessionType: null,
                    //         ));
                  },
                  color: Colors.white,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          CALLS_ENABLED
              ? IconButton(
                  tooltip: 'Video call',
                  constraints: BoxConstraints(maxWidth: 24, maxHeight: 24),
                  iconSize: 20,
                  icon: Icon(Icons.videocam),
                  onPressed: () {

                    // TODO:
                    // homeConversationModel.isGroupChat
                    //     ? push(
                    //         context,
                    //         VideoCallsGroupScreen(
                    //           isCaller: true,
                    //           homeConversationModel: homeConversationModel,
                    //           sessionDescription: null,
                    //           sessionType: null,
                    //           caller: HomeScreenState.currentUser,
                    //         ))
                    //     : push(
                    //         context,
                    //         VideoCallScreen(
                    //           isCaller: true,
                    //           homeConversationModel: homeConversationModel,
                    //           sessionDescription: null,
                    //           sessionType: null,
                    //         ));
                  },
                  color: Colors.white,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop("1");
                    homeConversationModel.isGroupChat
                        ? _onGroupChatSettingsClick()
                        : _onPrivateChatSettingsClick();
                  },
                  contentPadding: const EdgeInsets.all(0),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
              ];
            },
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData( color: Colors.white),
        backgroundColor: Color(COLOR_PRIMARY),
        title: homeConversationModel.isGroupChat
            ? Text(
          homeConversationModel.conversationModel?.name ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    homeConversationModel.members.first.fullName(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
            homeConversationModel.members.first.lastOnlineTimestamp !=
                null
                ? Padding(
              padding: const EdgeInsets.all(2.0),
              child: buildSubTitle(
                  homeConversationModel.members.first),
            )
                : Container(
              width: 0,
              height: 0,
            )
          ],
        ),
      ),
      body: Builder(builder: (BuildContext innerContext) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      currentRecordingState = RecordingState.HIDDEN;
                    });
                  },
                  child: StreamBuilder<ChatModel>(
                      stream: homeConversationModel.conversationModel != null
                          ? chatStream
                          : null,
                      initialData: ChatModel(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData &&
                              (snapshot.data.message.isEmpty ?? true)) {
                            return Center(child: Text('No messages yet'));
                          } else {
                            return ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data.message.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildMessage(
                                      snapshot.data.message[index],
                                      snapshot.data.members);
                                });
                          }
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: _onCameraClick,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Color(COLOR_PRIMARY),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 2.0, right: 2),
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: ShapeDecoration(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(360),
                                    ),
                                    borderSide:
                                    BorderSide(style: BorderStyle.none)),
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: _mRecorderIsInitialized,
                                    child: InkWell(
                                      onTap: () => _onMicClicked(),
                                      child: Icon(
                                        Icons.mic,
                                        color: currentRecordingState ==
                                                RecordingState.HIDDEN
                                            ? Color(COLOR_PRIMARY)
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (s) {
                                        setState(() {});
                                      },
                                      onTap: () {
                                        setState(() {
                                          currentRecordingState =
                                              RecordingState.HIDDEN;
                                        });
                                      },
                                      textAlignVertical:
                                      TextAlignVertical.center,
                                      controller: _messageController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        hintText: 'Start typing...',
                                        hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(360),
                                            ),
                                            borderSide: BorderSide(
                                                style: BorderStyle.none)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(360),
                                            ),
                                            borderSide: BorderSide(
                                                style: BorderStyle.none)),
                                      ),
                                      textCapitalization:
                                      TextCapitalization.sentences,
                                      maxLines: 5,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: _messageController.text.isEmpty
                              ? Color(COLOR_PRIMARY).withOpacity(.5)
                              : Color(COLOR_PRIMARY),
                        ),
                        onPressed: () async {
                          if (_messageController.text.isNotEmpty) {
                            _sendMessage(_messageController.text,
                                Url(mime: '', url: ''), '');
                            _messageController.clear();
                            setState(() {});
                          }
                        })
                  ],
                ),
              ),
              _buildAudioMessageRecorder(innerContext)
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAudioMessageRecorder(BuildContext innerContext) {
    return Visibility(
        visible: currentRecordingState != RecordingState.HIDDEN,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(child: Center(child: Text(audioMessageTime))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Stack(children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Visibility(
                            visible: currentRecordingState ==
                                RecordingState.Recording,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(COLOR_PRIMARY),
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(style: BorderStyle.none),
                                ),
                              ),
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () => _onSendRecord(),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Visibility(
                            visible: currentRecordingState ==
                                RecordingState.Recording,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade700,
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(style: BorderStyle.none),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () => _onCancelRecording(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible:
                            currentRecordingState == RecordingState.VISIBLE,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(style: BorderStyle.none),
                            ),
                          ),
                          child: Text(
                            'Record',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => _onStartRecording(innerContext),
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
          height: MediaQuery
              .of(context)
              .size
              .height * .3,
        ));
  }

  Widget buildSubTitle(User friend) {
    String text = friend.active
        ? 'Active now'
        : 'Last seen on '
            '${setLastSeen(friend.lastOnlineTimestamp.seconds)}';
    return Text(text,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade200));
  }

  _onGroupChatSettingsClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Group Chat Settings",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text("Leave Group"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            showProgress(context, 'Leaving group chat', false);
            bool isSuccessful = await _fireStoreUtils
                .leaveGroup(homeConversationModel.conversationModel);
            hideProgress();
            if (isSuccessful) {
              Navigator.of(context, rootNavigator: true).pop("1");
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Rename Group"),
          isDefaultAction: true,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            showDialog(
                context: context,
                builder: (context) {
                  return _showRenameGroupDialog();
                });
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop("1");
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Send Media",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose image from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.gallery);
            if (image != null) {
              Url url = await _fireStoreUtils.uploadChatImageToFireStorage(
                  File(image.path), context);
              _sendMessage('', url, '');
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Choose video from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            PickedFile galleryVideo =
                await _imagePicker.getVideo(source: ImageSource.gallery);
            if (galleryVideo != null) {
              ChatVideoContainer videoContainer =
                  await _fireStoreUtils.uploadChatVideoToFireStorage(
                      File(galleryVideo.path), context);
              _sendMessage(
                  '', videoContainer.videoUrl, videoContainer.thumbnailUrl);
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.camera);
            if (image != null) {
              Url url = await _fireStoreUtils.uploadChatImageToFireStorage(
                  File(image.path), context);
              _sendMessage('', url, '');
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Record video"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            PickedFile recordedVideo =
                await _imagePicker.getVideo(source: ImageSource.camera);
            if (recordedVideo != null) {
              ChatVideoContainer videoContainer =
                  await _fireStoreUtils.uploadChatVideoToFireStorage(
                      File(recordedVideo.path), context);
              _sendMessage(
                  '', videoContainer.videoUrl, videoContainer.thumbnailUrl);
            }
          },
        )
      ],
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Widget buildMessage(MessageData messageData, List<User> members) {
    if (messageData.senderID == HomeScreenState.currentUser.userID) {
      return myMessageView(messageData);
    } else {
      return remoteMessageView(
          messageData,
          members.where((user) {
            return user.userID == messageData.senderID;
          }).first);
    }
  }

  Widget myMessageView(MessageData messageData) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: _myMessageContentWidget(messageData)),
          displayCircleImage(messageData.senderProfilePictureURL, 35, false)
        ],
      ),
    );
  }

  Widget _myMessageContentWidget(MessageData messageData) {
    var mediaUrl = '';
    if (messageData.url != null && messageData.url.url.isNotEmpty) {
      if (messageData.url.mime.contains('image')) {
        mediaUrl = messageData.url.url;
      } else if (messageData.url.mime.contains('video')) {
        mediaUrl = messageData.videoThumbnail;
      } else if (messageData.url.mime.contains('audio')) {
        mediaUrl = messageData.url.url;
      }
    }
    if (mediaUrl.contains('audio')) {
      return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Positioned(
              right: -8,
              bottom: 0,
              child: Image.asset(
                'assets/images/matchmaking/chat_arrow_right.png',
                color: Color(COLOR_ACCENT),
                height: 12,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: 200,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(COLOR_ACCENT),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, right: 4, left: 4),
                          child: PlayerWidget(
                            url: messageData.url.url,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ]);
    } else if (mediaUrl.isNotEmpty) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 200,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(alignment: Alignment.center, children: [
              GestureDetector(
                onTap: () {
                  // TODO:
                  if (messageData.videoThumbnail.isEmpty) {
                    push(
                        context,
                        FullScreenImageViewer(
                          imageUrl: mediaUrl,
                        ));
                  }
                },
                child: Hero(
                  tag: mediaUrl,
                  child: ExtendedImage.network(
                    mediaUrl,
                    fit: BoxFit.cover,
                    cache: true,
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return Center(child: OBProgressIndicator());
                          break;
                        case LoadState.failed:
                          return Image.asset('assets/images/matchmaking/error_image'
                                        '.png');
                          break;
                        default:
                          return Image.asset('assets/images/matchmaking/img_placeholder'
                                        '.png');
                          break;  
                      }
                    },
                  ),
                ),
              ),
              messageData.videoThumbnail.isNotEmpty
                  ? FloatingActionButton(
                      mini: true,
                      heroTag: messageData.messageID,
                      backgroundColor: Color(COLOR_ACCENT),
                      onPressed: () {

                        // TODO:
                        // push(
                        //     context,
                        //     FullScreenVideoViewer(
                        //       heroTag: messageData.messageID,
                        //       videoUrl: messageData.url.url,
                        //     ));
                      },
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                width: 0,
                height: 0,
              )
            ]),
          ));
    } else {
      return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Positioned(
              right: -8,
              bottom: 0,
              child: Image.asset(
                'assets/images/matchmaking/chat_arrow_right.png',
                color: Color(COLOR_ACCENT),
                height: 12,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: 200,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(COLOR_ACCENT),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, right: 4, left: 4),
                          child: Text(
                            mediaUrl.isEmpty ? messageData.content : '',
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ]);
    }
  }

  Widget remoteMessageView(MessageData messageData, User sender) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              displayCircleImage(sender.profilePictureURL, 35, false),
              Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: homeConversationModel.members
                            .firstWhere((element) =>
                        element.userID == messageData.senderID)
                            .active
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: Colors.white,
                            width: 1)),
                  ))
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: _remoteMessageContentWidget(messageData)),
        ],
      ),
    );
  }

  Widget _remoteMessageContentWidget(MessageData messageData) {
    var mediaUrl = '';
    if (messageData.url != null && messageData.url.url.isNotEmpty) {
      if (messageData.url.mime.contains('image')) {
        mediaUrl = messageData.url.url;
      } else if (messageData.url.mime.contains('video')) {
        mediaUrl = messageData.videoThumbnail;
      } else if (messageData.url.mime.contains('audio')) {
        mediaUrl = messageData.url.url;
      }
    }
    if (mediaUrl.contains('audio')) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            left: -8,
            bottom: 0,
            child: Image.asset(
              'assets/images/matchmaking/chat_arrow_left.png',
              color: Colors.grey[300],
              height: 12,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 50,
              maxWidth: 200,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, right: 4, left: 4),
                          child: PlayerWidget(
                            url: messageData.url.url,
                            color: Color(COLOR_PRIMARY),
                          )),
                    ]),
              ),
            ),
          ),
        ],
      );
    } else if (mediaUrl.isNotEmpty) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            maxWidth: 200,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(alignment: Alignment.center, children: [
              GestureDetector(
                onTap: () {

                  // TODO:
                  // if (messageData.videoThumbnail.isEmpty) {
                  //   push(
                  //       context,
                  //       FullScreenImageViewer(
                  //         imageUrl: mediaUrl,
                  //       ));
                  // }
                },
                child: Hero(
                  tag: mediaUrl,
                  child: ExtendedImage.network(
                    mediaUrl,
                    fit: BoxFit.cover,
                    cache: true,
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return Center(child: OBProgressIndicator());
                          break;
                        case LoadState.failed:
                          return Image.asset('assets/images/matchmaking/error_image'
                                        '.png');
                          break;
                        default:
                          return Image.asset('assets/images/matchmaking/img_placeholder'
                                        '.png');
                          break;  
                      }
                    },
                  ),
                ),
              ),
              messageData.videoThumbnail.isNotEmpty
                  ? FloatingActionButton(
                      mini: true,
                      heroTag: messageData.messageID,
                      backgroundColor: Color(COLOR_ACCENT),
                      onPressed: () {

                        // TODO:
                        // push(
                        //     context,
                        //     FullScreenVideoViewer(
                        //       heroTag: messageData.messageID,
                        //       videoUrl: messageData.url.url,
                        //     ));
                      },
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                width: 0,
                height: 0,
              )
            ]),
          ));
    } else {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            left: -8,
            bottom: 0,
            child: Image.asset(
              'assets/images/matchmaking/chat_arrow_left.png',
              color: Colors.grey.shade300,
              height: 12,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 50,
              maxWidth: 200,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, right: 4, left: 4),
                        child: Text(
                          mediaUrl.isEmpty ? messageData.content : '',
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<bool> _checkChannelNullability(
      ConversationModel conversationModel) async {
    if (conversationModel != null) {
      return true;
    } else {
      String channelID;
      User friend = homeConversationModel.members.first;
      User user = HomeScreenState.currentUser;
      if (friend.userID.compareTo(user.userID) < 0) {
        channelID = friend.userID + user.userID;
      } else {
        channelID = user.userID + friend.userID;
      }

      ConversationModel conversation = ConversationModel(
          creatorId: user.userID,
          id: channelID,
          lastMessageDate: Timestamp.now(),
          lastMessage: ''
              '${user.fullName()} sent a message');
      bool isSuccessful =
      await _fireStoreUtils.createConversation(conversation);
      if (isSuccessful) {
        homeConversationModel.conversationModel = conversation;
        setupStream();
        setState(() {});
      }
      return isSuccessful;
    }
  }

  _sendMessage(String content, Url url, String videoThumbnail) async {
    MessageData message;
    if (homeConversationModel.isGroupChat) {
      message = MessageData(
          content: content,
          created: Timestamp.now(),
          senderFirstName: HomeScreenState.currentUser.firstName,
          senderID: HomeScreenState.currentUser.userID,
          senderLastName: HomeScreenState.currentUser.lastName,
          senderProfilePictureURL: HomeScreenState.currentUser.profilePictureURL,
          url: url,
          videoThumbnail: videoThumbnail);
    } else {
      message = MessageData(
          content: content,
          created: Timestamp.now(),
          recipientFirstName: homeConversationModel.members.first.firstName,
          recipientID: homeConversationModel.members.first.userID,
          recipientLastName: homeConversationModel.members.first.lastName,
          recipientProfilePictureURL:
              homeConversationModel.members.first.profilePictureURL,
          senderFirstName: HomeScreenState.currentUser.firstName,
          senderID: HomeScreenState.currentUser.userID,
          senderLastName: HomeScreenState.currentUser.lastName,
          senderProfilePictureURL: HomeScreenState.currentUser.profilePictureURL,
          url: url,
          videoThumbnail: videoThumbnail);
    }
    if (url != null) {
      if (url.mime.contains('image')) {
        message.content = '${HomeScreenState.currentUser.firstName} sent an image';
      } else if (url.mime.contains('video')) {
        message.content = '${HomeScreenState.currentUser.firstName} sent a video';
      } else if (url.mime.contains('audio')) {
        message.content = '${HomeScreenState.currentUser.firstName} sent a voice '
            'message';
      }
    }
    if (await _checkChannelNullability(
        homeConversationModel.conversationModel)) {
      await _fireStoreUtils.sendMessage(
          homeConversationModel.members,
          homeConversationModel.isGroupChat,
          message,
          homeConversationModel.conversationModel);
      homeConversationModel.conversationModel.lastMessageDate =
          Timestamp.now();
      homeConversationModel.conversationModel.lastMessage = message.content;

      await _fireStoreUtils
          .updateChannel(homeConversationModel.conversationModel);
    } else {
      showAlertDialog(context, 'An Error Occurred',
          'Couldn\'t send Message, please try again later');
    }
  }

  @override
  void dispose() {
    _myRecorder.closeAudioSession();
    _myRecorder = null;
    _messageController.dispose();
    _groupNameController.dispose();
    super.dispose();
  }

  Widget _showRenameGroupDialog() {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 16,
        child: Container(
          height: 200,
          width: 350,
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Color(COLOR_ACCENT), width: 2.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      labelText: 'Group name',
                    ),
                  ),
                  Spacer(),
                  Wrap(
                    spacing: 30,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop("1");
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            if (_groupNameController.text.isNotEmpty) {
                              if (homeConversationModel
                                      .conversationModel.name !=
                                  _groupNameController.text) {
                                showProgress(context,
                                    'Renaming group, Please wait...', false);
                                homeConversationModel.conversationModel.name =
                                    _groupNameController.text.trim();
                                await _fireStoreUtils.updateChannel(
                                    homeConversationModel.conversationModel);
                                hideProgress();
                              }
                              Navigator.of(context, rootNavigator: true).pop("1");
                              setState(() {});
                            }
                          },
                          child: Text('Rename',
                              style: TextStyle(
                                  fontSize: 18, color: Color(COLOR_ACCENT)))),
                    ],
                  )
                ],
              )),
        ));
  }


  _onPrivateChatSettingsClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Chat Settings",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Block user"),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            showProgress(context, 'Blocking user...', false);
            bool isSuccessful = await _fireStoreUtils.blockUser(
                homeConversationModel.members.first, 'block');
            hideProgress();
            if (isSuccessful) {
              Navigator.of(context, rootNavigator: true).pop("1");
              _showAlertDialog(context, 'Block',
                  '${homeConversationModel.members.first
                      .fullName()} has been blocked.');
            } else {
              _showAlertDialog(
                  context,
                  'Block',
                  'Couldn'
                      '\'t block ${homeConversationModel.members.first
                      .fullName()}, please try again later.');
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Report user"),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop("1");
            showProgress(context, 'Reporting user...', false);
            bool isSuccessful = await _fireStoreUtils.blockUser(
                homeConversationModel.members.first, 'report');
            hideProgress();
            if (isSuccessful) {
              Navigator.of(context, rootNavigator: true).pop("1");
              _showAlertDialog(context, 'Report',
                  '${homeConversationModel.members.first
                      .fullName()} has been reported and blocked.');
            } else {
              _showAlertDialog(
                  context,
                  'Report',
                  'Couldn'
                      '\'t report ${homeConversationModel.members.first
                      .fullName()}, please try again later.');
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop("1");
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _onMicClicked() async {
    if (currentRecordingState == RecordingState.HIDDEN) {
      FocusScope.of(context).unfocus();
      Directory tempDir = await getTemporaryDirectory();
      var uniqueID = Uuid().v4();
      tempPathForAudioMessages = '${tempDir.path}/$uniqueID';
      currentRecordingState = RecordingState.VISIBLE;
    } else {
      currentRecordingState = RecordingState.HIDDEN;
    }
    setState(() {});
  }

  _onSendRecord() async {
    await _myRecorder.stopRecorder();
    audioMessageTimer.cancel();
    setState(() {
      audioMessageTime = 'Start Recording';
      currentRecordingState = RecordingState.HIDDEN;
    });
    Url url = await _fireStoreUtils.uploadAudioFile(
        File(tempPathForAudioMessages), context);
    _sendMessage('', url, '');
  }

  _onCancelRecording() async {
    await _myRecorder.stopRecorder();
    audioMessageTimer.cancel();
    setState(() {
      audioMessageTime = 'Start Recording';
      currentRecordingState = RecordingState.VISIBLE;
    });
  }

  _onStartRecording(BuildContext innerContext) async {
    await _myRecorder
        .startRecorder(toFile: tempPathForAudioMessages, codec: Codec.aacADTS);
    audioMessageTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        audioMessageTime = updateTime(audioMessageTimer);
      });
    });
    setState(() {
      currentRecordingState = RecordingState.Recording;
    });
  }
}