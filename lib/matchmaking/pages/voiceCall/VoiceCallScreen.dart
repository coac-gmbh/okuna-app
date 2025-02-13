import 'dart:async';
import 'dart:ui';

import 'package:Okuna/matchmaking/constants.dart';
import 'package:Okuna/matchmaking/model/HomeConversationModel.dart';
import 'package:Okuna/matchmaking/pages/HomeScreen.dart';
import 'package:Okuna/matchmaking/pages/voiceCall/VoiceCallsHandler.dart';
import 'package:Okuna/matchmaking/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:wakelock/wakelock.dart';

class VoiceCallScreen extends StatefulWidget {
  final HomeConversationModel homeConversationModel;
  final bool isCaller;
  final String sessionDescription;
  final String sessionType;

  const VoiceCallScreen(
      {Key key,
      @required this.homeConversationModel,
      @required this.isCaller,
      @required this.sessionDescription,
      @required this.sessionType})
      : super(key: key);

  @override
  _VoiceCallScreenState createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  VoiceCallsHandler _signaling;
  bool _isCallActive = false, _micOn = true, _speakerOn = true;
  MediaStream _localStream;
  String _callDuration = '';

  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (!widget.isCaller) {
      FlutterRingtonePlayer.playRingtone();
      print('_VideoCallScreenState.initState');
    }
    _connect();
    if (!widget.isCaller) {
      _signaling.listenForMessages();

      _signaling.startCountDown(context);
      _signaling.setupOnRemoteHangupListener(context);
    }
    Wakelock.enable();
  }

  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
  }

  @override
  void dispose() {
    _signaling.hangupSub?.cancel();
    _signaling.countdownTimer?.cancel();
    _signaling.timer?.cancel();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (!widget.isCaller) {
      print('FlutterRingtonePlayer dispose lets stop');
      FlutterRingtonePlayer.stop();
    }
    super.dispose();
    Wakelock.disable();
  }

  void _connect() async {
    _signaling = VoiceCallsHandler(
        isCaller: widget.isCaller,
        homeConversationModel: widget.homeConversationModel);

    _signaling.onStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.CallStateNew:
          break;
        case SignalingState.CallStateBye:
          this.setState(() {
            _isCallActive = false;
          });
          break;
        case SignalingState.CallStateInvite:
        case SignalingState.CallStateConnected:
          {
            if (mounted) {
              if (_signaling.timer == null) {
                print(
                    '_VoiceCallScreenState._connect _signaling.timer == null');
                // ignore: missing_return
                _signaling.startCallDurationTimer((Timer timer) {
                  setState(() {
                    print('_VoiceCallScreenState._connect ${timer.tick}');
                    _callDuration = updateTime(timer);
                  });
                });
              } else {
                if (!(_signaling.timer?.isActive ?? true)) {
                  print(
                      '_VoiceCallScreenState._connect !_signaling.timer.isActive');
                  // ignore: missing_return
                  _signaling.startCallDurationTimer((Timer timer) {
                    setState(() {
                      _callDuration = updateTime(timer);
                    });
                  });
                }
              }
              print('_VoiceCallScreenState._connect');
              setState(() {
                _isCallActive = true;
              });
            }

            break;
          }
        case SignalingState.CallStateRinging:
        case SignalingState.ConnectionClosed:
        case SignalingState.ConnectionError:
        case SignalingState.ConnectionOpen:
          break;
      }
    };
    _signaling.onLocalStream = ((stream) {
      if (mounted) {
        _localStream = stream;
        _localStream.getAudioTracks()[0].enableSpeakerphone(_speakerOn);
        _localStream.getAudioTracks()[0].setMicrophoneMute(!_micOn);
      }
    });

    _signaling.onAddRemoteStream = ((stream) {
      if (mounted)
        setState(() {
          _isCallActive = true;
        });
    });

    _signaling.onRemoveRemoteStream = ((stream) {
      if (mounted)
        setState(() {
          _isCallActive = false;
        });
    });
    if (widget.isCaller)
      _signaling.initCall(widget.homeConversationModel.members.first.fcmToken,
          widget.homeConversationModel.members.first.userID, context);
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Material(child: OrientationBuilder(builder: (context, orientation) {
      return Container(
        child: Stack(
            children: skipNulls([
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget
                        .homeConversationModel.members.first.profilePictureURL),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: orientation == Orientation.portrait ? 80 : 15),
                    child: SizedBox(width: double.infinity),
                  ),
                  displayCircleImage(
                      widget.homeConversationModel.members.first.profilePictureURL,
                      75,
                      true),
                  SizedBox(height: 10),
                  Text(
                    _isCallActive
                        ? widget.homeConversationModel.members.first.fullName()
                        : widget.isCaller
                        ? 'Voice calling ${widget.homeConversationModel.members.first.fullName()}'
                        : '${widget.homeConversationModel.members.first.fullName()} is Voice Calling',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _signaling.timer != null && _signaling.timer.isActive
                    ? _callDuration
                    : widget.isCaller
                        ? 'Ringing...'
                        : '',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
                ],
              ),
              Positioned(
                bottom: 40,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: skipNulls(
                    [
                      widget.isCaller || _isCallActive
                          ? null
                          : FloatingActionButton(
                          backgroundColor: Colors.green,
                          heroTag: 'answerFAB',
                          child: Icon(Icons.call),
                          onPressed: () {
                            FlutterRingtonePlayer.stop();
                            _signaling.countdownTimer?.cancel();
                            _signaling.acceptCall(widget.sessionDescription,
                                widget.sessionType);
                            setState(() {
                              _isCallActive = true;
                            });
                          }),
                      _isCallActive
                          ? FloatingActionButton(
                        backgroundColor: Color(COLOR_ACCENT),
                        heroTag: 'speakerFAB',
                        child: Icon(
                            _speakerOn ? Icons.volume_up : Icons.volume_off),
                        onPressed: _speakerToggle,
                      )
                          : null,
                      FloatingActionButton(
                        heroTag: 'hangupFAB',
                        onPressed: () => _hangUp(),
                        tooltip: 'Hangup',
                        child: Icon(Icons.call_end),
                        backgroundColor: Colors.pink,
                      ),
                      _isCallActive
                          ? FloatingActionButton(
                        backgroundColor: Color(COLOR_ACCENT),
                        heroTag: 'micFAB',
                        child: Icon(_micOn ? Icons.mic : Icons.mic_off),
                        onPressed: _micToggle,
                      )
                          : null
                    ],
                  ),
                ),
              ),
            ])),
      );
    }));
  }

  _hangUp() {
    if (_signaling != null) {
      _signaling.countdownTimer?.cancel();
      _signaling.bye();
    }
    if (!widget.isCaller) {
      print('FlutterRingtonePlayer _hangUp lets stop');
      FlutterRingtonePlayer.stop();
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    HomeScreen()), (route) => false);
  }

  _micToggle() {
    setState(() {
      _micOn = _micOn ? false : true;
      _localStream.getAudioTracks()[0].setMicrophoneMute(!_micOn);
    });
  }

  _speakerToggle() {
    setState(() {
      _speakerOn = _speakerOn ? false : true;
      _localStream.getAudioTracks()[0].enableSpeakerphone(_speakerOn);
    });
  }
}
