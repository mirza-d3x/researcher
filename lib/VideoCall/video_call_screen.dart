import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = "c6d57be0ce654e3e9735442565fad0e5";

class VideoCallingScreen extends StatefulWidget {
  const VideoCallingScreen({super.key});

  @override
  State<VideoCallingScreen> createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  String channelName = "agora";
  String token =
      "1:c6d57be0ce654e3e9735442565fad0e5:1683368018:c9c2a4a8424d60864e629119311d21b2d0a21126cc937b894b44db950642a306:0:agora:";
  int uid = 0;

  int? _remoteUid;
  bool _isJoined = false;
  late RtcEngine agoraEngine;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    setupVideoSDKEngine();
    super.initState();
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get started with Video Calling'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: _localPreview(),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: _remoteVideo(),
            ),
          ),
          // Button Row
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: _isJoined
                      ? null
                      : () => {
                            join(),
                          },
                  child: const Text("Join"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isJoined
                      ? () => {
                            leave(),
                          }
                      : null,
                  child: const Text("Leave"),
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 300,
          //       height: 20,
          //       child: Text(
                 
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () async {
          //         await Clipboard.setData(
          //           ClipboardData(
          //             text: generateToken(
          //                 appId,
          //                 "87fdb0b082144320a2ed379e399b16a7",
          //                 channelName,
          //                 uid,
          //                 100000),
          //           ),
          //         );
          //       },
          //       icon: Icon(Icons.copy),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }

  void join() async {
    await agoraEngine.startPreview();

    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }
}

// generateToken() async {
//   final _engine =
//       await RtcEngine.createWithConfig(RtcEngineConfig('<YOUR APP ID>'));
// }
