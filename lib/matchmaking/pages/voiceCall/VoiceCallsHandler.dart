import 'dart:async';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/ConversationModel.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/model/MessageData.dart';
import 'package:Okuna/matchmaking/model/User.dart';
import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/matchmaking/services/FirebaseHelper.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum SignalingState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}

/*
 * callbacks for Signaling API.
 */
typedef void SignalingStateCallback(SignalingState state);
typedef void StreamStateCallback(MediaStream stream);
typedef void OtherEventCallback(dynamic event);

class VoiceCallsHandler {
  Timer countdownTimer;
  var _peerConnections = new Map<String, RTCPeerConnection>();
  var _remoteCandidates = [];
  List<dynamic> _localCandidates = [];
  StreamSubscription hangupSub;
  MediaStream _localStream;
  List<MediaStream> _remoteStreams;
  SignalingStateCallback onStateChange;
  StreamStateCallback onLocalStream;
  StreamStateCallback onAddRemoteStream;
  StreamStateCallback onRemoveRemoteStream;
  OtherEventCallback onPeersUpdate;
  String _selfId = HomeScreenState.currentUser.userID;
  final bool isCaller;
  final HomeConversationModel homeConversationModel;
  Timer timer;
  StreamSubscription<DocumentSnapshot> messagesStreamSubscription;

  FireStoreUtils _fireStoreUtils = FireStoreUtils();

  VoiceCallsHandler(
      {@required this.isCaller, @required this.homeConversationModel});

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      {
        'url': 'turn:95.217.132.49:80?transport=udp',
        'username': 'c38d01c8',
        'credential': 'f7bf2454'
      },
      {
        'url': 'turn:95.217.132.49:80?transport=tcp',
        'username': 'c38d01c8',
        'credential': 'f7bf2454'
      },
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  close() {
    if (_localStream != null) {
      _localStream.dispose();
      _localStream = null;
    }
    hangupSub?.cancel();
    if (messagesStreamSubscription != null) {
      messagesStreamSubscription.cancel();
    }
    _peerConnections.forEach((key, pc) {
      pc.close();
    });
  }

  void initCall(String fcmToken, String peerID, BuildContext context) async {
    if (this.onStateChange != null) {
      this.onStateChange(SignalingState.CallStateNew);
    }

    _createPeerConnection(peerID).then((pc) async {
      _peerConnections[peerID] = pc;
      await _createOffer(fcmToken, peerID, pc, context);
      startCountDown(context);
      listenForMessages();
      setupOnRemoteHangupListener(context);
    });
  }

  setupOnRemoteHangupListener(BuildContext context) {
    Stream<DocumentSnapshot> hangupStream = FireStoreUtils.firestore
        .collection(USERS)
        .doc(homeConversationModel.members.first.userID)
        .collection(CALL_DATA)
        .doc(isCaller ? _selfId : homeConversationModel.members.first.userID)
        .snapshots();
    print('${isCaller ? _selfId : homeConversationModel.members.first.userID}');
    hangupSub = hangupStream.listen((event) {
      if (!event.exists) {
        print('VoiceCallsHandler.setupOnRemoteHangupListener');
        Navigator.maybePop(context);
      }
    });
  }

  void bye() async {
    print('VoiceCallsHandler.bye');
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(_selfId)
        .collection(CALL_DATA)
        .doc(isCaller ? _selfId : homeConversationModel.members.first.userID)
        .delete();
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(homeConversationModel.members.first.userID)
        .collection(CALL_DATA)
        .doc(isCaller ? _selfId : homeConversationModel.members.first.userID)
        .delete();
  }

  void onMessage(Map<String, dynamic> message) async {
    Map<String, dynamic> mapData = message;
    var data = mapData['data'];

    switch (mapData['type']) {
      case 'offer':
        {
          var id = data['from'];
          if (id != _selfId) {
            print('VoiceCallsHandler.onMessage offer');
          } else {
            print('VoiceCallsHandler.onMessage you offered a call');
          }
        }
        break;
      case 'answer':
        {
          var id = data['from'];

          if (id != _selfId) {
            countdownTimer?.cancel();
            print('VoiceCallsHandler.onMessage answer');
            var description = data['description'];
            if (this.onStateChange != null)
              this.onStateChange(SignalingState.CallStateConnected);
            var pc = _peerConnections[id];
            if (pc != null) {
              await pc.setRemoteDescription(new RTCSessionDescription(
                  description['sdp'], description['type']));
            }

            _sendCandidate('candidate',
                {'to': id, 'from': _selfId, 'candidate': _localCandidates});
          } else {
            print('VoiceCallsHandler.onMessage you answered the call');
          }
        }
        break;
      case 'candidate':
        {
          var id = data['from'];
          if (id != _selfId) {
            print('VoiceCallsHandler.onMessage candidate');
            List<dynamic> candidates = data['candidate'];
            var pc = _peerConnections[id];
            candidates.forEach((candidateMap) async {
              RTCIceCandidate candidate = new RTCIceCandidate(
                  candidateMap['candidate'],
                  candidateMap['sdpMid'],
                  candidateMap['sdpMLineIndex']);
              if (pc != null) {
                await pc.addCandidate(candidate);
              } else {
                _remoteCandidates.add(candidate);
              }
            });

            if (this.onStateChange != null)
              this.onStateChange(SignalingState.CallStateConnected);
          } else {
            print('VoiceCallsHandler.onMessage you sent candidate');
          }
        }
        break;
      default:
        break;
    }
  }

  Future<MediaStream> createStream() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': false
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    if (this.onLocalStream != null) {
      this.onLocalStream(stream);
    }
    return stream;
  }

  Future<RTCPeerConnection> _createPeerConnection(id) async {
    _localStream = await createStream();
    RTCPeerConnection pc = await createPeerConnection(_iceServers, _config);
    pc.addStream(_localStream);
    pc.onIceCandidate = (RTCIceCandidate candidate) {
      _localCandidates.add(candidate.toMap());
    };
    pc.onAddStream = (stream) {
      if (this.onAddRemoteStream != null) this.onAddRemoteStream(stream);
    };
    pc.onRemoveStream = (stream) {
      if (this.onRemoveRemoteStream != null) this.onRemoveRemoteStream(stream);
      _remoteStreams?.removeWhere((MediaStream it) {
        return (it.id == stream.id);
      });
    };
    return pc;
  }

  _createOffer(String fcmToken, String id, RTCPeerConnection pc,
      BuildContext context) async {
    try {
      RTCSessionDescription s = await pc.createOffer(_constraints);
      pc.setLocalDescription(s);
      await _sendOffer(
          fcmToken,
          'offer',
          {
            'to': id,
            'from': _selfId,
            'description': {'sdp': s.sdp, 'type': s.type},
          },
          context);
    } catch (e) {
      print(e.toString());
    }
  }

  _createAnswer(String id, RTCPeerConnection pc) async {
    try {
      RTCSessionDescription s = await pc.createAnswer(_constraints);
      pc.setLocalDescription(s);
      _sendAnswer('answer', {
        'to': id,
        'from': _selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _sendOffer(String fcmToken, String event, Map<String, dynamic> data,
      BuildContext context) async {
    var request = new Map<String, dynamic>();
    request['type'] = event;
    request['data'] = data;
    request['callerName'] = HomeScreenState.currentUser.fullName();
    request['callType'] = 'voice';
    request['isGroupCall'] = false;
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(homeConversationModel.members.first.userID)
        .collection(CALL_DATA)
        .get(GetOptions(source: Source.server))
        .then((value) async {
      if (value.docs.isEmpty) {
        //send offer to call
        await FireStoreUtils.firestore
            .collection(USERS)
            .doc(_selfId)
            .collection(CALL_DATA)
            .doc(_selfId)
            .set(request);
        await FireStoreUtils.firestore
            .collection(USERS)
            .doc(data['to'])
            .collection(CALL_DATA)
            .doc(_selfId)
            .set(request);
        updateChat(context);
      } else {
        showAlertDialog(context, 'Call', 'this user has an on-going call');
      }
    });
  }

  listenForMessages() {
    Stream<DocumentSnapshot> messagesStream = FireStoreUtils.firestore
        .collection(USERS)
        .doc(
        isCaller ? _selfId : homeConversationModel.members.first.userID)
        .collection(CALL_DATA)
        .doc(
        isCaller ? _selfId : homeConversationModel.members.first.userID)
        .snapshots();
    messagesStreamSubscription = messagesStream.listen((call) {
      if (call.exists) onMessage(call.data() ?? {});
    });
  }

  void startCountDown(BuildContext context) {
    print('VoiceCallsHandler.startCountDown');
    countdownTimer = Timer(Duration(minutes: 1), () {
      print('VoiceCallsHandler.startCountDown bye');
      bye();
      if (!isCaller) {
        print('FlutterRingtonePlayer _hangUp lets stop');
        FlutterRingtonePlayer.stop();
      }
      Navigator.of(context).pop();
    });
  }

  acceptCall(String sessionDescription, String sessionType) async {
    if (this.onStateChange != null) {
      this.onStateChange(SignalingState.CallStateNew);
    }
    String id = homeConversationModel.members.first.userID;
    RTCPeerConnection pc = await _createPeerConnection(id);
    _peerConnections[id] = pc;
    await pc.setRemoteDescription(
        new RTCSessionDescription(sessionDescription, sessionType));
    await _createAnswer(id, pc);
    if (this._remoteCandidates.length > 0) {
      _remoteCandidates.forEach((candidate) async {
        await pc.addCandidate(candidate);
      });
      _remoteCandidates.clear();
    }
  }

  void _sendAnswer(String event, Map<String, dynamic> data) async {
    var request = new Map<String, dynamic>();
    request['type'] = event;
    request['data'] = data;

    //send answer to call
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(_selfId)
        .collection(CALL_DATA)
        .doc(data['to'])
        .set(request);
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(data['to'])
        .collection(CALL_DATA)
        .doc(data['to'])
        .set(request);
    _sendCandidate('candidate',
        {'to': data['to'], 'from': _selfId, 'candidate': _localCandidates});
    if (this.onStateChange != null)
      this.onStateChange(SignalingState.CallStateConnected);
  }

  _sendCandidate(String event, Map<String, dynamic> data) async {
    var request = new Map<String, dynamic>();
    request['type'] = event;
    request['data'] = data;

    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(_selfId)
        .collection(CALL_DATA)
        .doc(isCaller ? _selfId : data['to'])
        .set(request);
    await FireStoreUtils.firestore
        .collection(USERS)
        .doc(data['to'])
        .collection(CALL_DATA)
        .doc(isCaller ? _selfId : data['to'])
        .set(request);
  }

  startCallDurationTimer(VoidCallback callback(Timer timer)) {
    timer = Timer.periodic(Duration(seconds: 1), callback);
  }

  void updateChat(BuildContext context) async {
    MessageData message = MessageData(
        content: '${HomeScreenState.currentUser.fullName()} Started a voice call.',
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
        url: Url(mime: '', url: ''),
        videoThumbnail: '');
    if (await _checkChannelNullability(
        homeConversationModel.conversationModel)) {
      await _fireStoreUtils.sendMessage(
        homeConversationModel.members,
        homeConversationModel.isGroupChat,
        message,
        homeConversationModel.conversationModel,
      );
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
      }
      return isSuccessful;
    }
  }
}
