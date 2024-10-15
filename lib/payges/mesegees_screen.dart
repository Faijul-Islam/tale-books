import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

import '../controler/coll_controler.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true, // To show latest messages at the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageData = messages[index];
                    var messageText = messageData['message'];
                    var senderId = messageData['senderId'];

                    return ListTile(
                      title: Text(senderId),
                      subtitle: Text(messageText),
                    );
                  },
                );
              },
            ),
          ),
          MessageInputWidget(), // Widget for inputting and sending messages
        ],
      ),
    );
  }
}

class MessageInputWidget extends StatefulWidget {
  @override
  _MessageInputWidgetState createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final messageText = _controller.text.trim();
    if (messageText.isNotEmpty) {
      sendMessage('user123', messageText); // Replace 'user123' with the actual sender ID
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter message...'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

Future<void> sendMessage(String senderId, String message) async {
  await FirebaseFirestore.instance.collection('messages').add({
    'senderId': senderId,
    'message': message,
    'timestamp': FieldValue.serverTimestamp(),
  });
}



class CatApp extends StatefulWidget {
  const CatApp({Key? key}) : super(key: key);

  @override
  State<CatApp> createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "c3ff41cbb2ad4c19abe61753bebc658d",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: "007eJxTYOjO16yQeDPnzeX8KTJuXp9O5LXnGhcFJxzeltPZFG1gbK7AkGyclmZimJyUZJSYYpJsaJmYlGpmaG5qnJSalGxmapESo/UtrSGQkSHK/woDIxSC+DwMJanFJfFpOaUlJalFDAwAZ+EjIg==",
      channelId: "test_flutter",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: "test_flutter"),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}


class VideoCall extends StatefulWidget {
  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final callCon = Get.put(CallController());

  @override
  void initState() {
    super.initState();
    //WakelockPlus.enable(); // Turn on wakelock feature till call is running
  }

  @override
  void dispose() {
     //_engine.leaveChannel();
    // _engine.destroy();
    //WakelockPlus.disable(); // Turn off wakelock feature after call end
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() => Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Center(
                  child: callCon.localUserJoined == true
                      ? callCon.videoPaused == true
                      ? Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        "Remote Video Paused",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white70),
                      ),
                    ),
                  )
                      : (callCon.myremoteUid.value != null &&
                      callCon.myremoteUid.value != 0)
                      ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: callCon.engine,
                      canvas: VideoCanvas(
                          uid: callCon.myremoteUid.value),
                      connection: const RtcConnection(
                          channelId: "test_flutter"),
                    ),
                  )
                      : Container(
                    color: Theme.of(context).primaryColor,
                    child: const Center(
                      child: Text(
                        'Waiting for Remote User',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      : const Center(
                    child: Text(
                      'No Remote User',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: callCon.localUserJoined.value
                          ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: callCon.engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callCon.onToggleMute();
                          },
                          child: Icon(
                            callCon.muted.value ? Icons.mic : Icons.mic_off,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callCon.onCallEnd();
                          },
                          child: const Icon(
                            Icons.call,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callCon.onVideoOff();
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  Icons.photo_camera_front,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            callCon.onSwitchCamera();
                          },
                          child: const Icon(
                            Icons.switch_camera,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))

      ),
    );
  }
}


class ChatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatListState();
}

class ChatListState extends State<ChatList> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRoleType? _role = ClientRoleType.clientRoleBroadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Calling'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                        errorText:
                        _validateError ? 'Channel name is mandatory' : null,
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Channel name',
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title:
                    Text(ClientRoleType.clientRoleBroadcaster.toString()),
                    leading: Radio(
                      value: ClientRoleType.clientRoleBroadcaster,
                      groupValue: _role,
                      onChanged: (ClientRoleType? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRoleType.clientRoleAudience.toString()),
                    leading: Radio(
                      value: ClientRoleType.clientRoleAudience,
                      groupValue: _role,
                      onChanged: (ClientRoleType? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onJoin,
                        child: const Text('Video Call'),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                      ),
                    ),
                    // Expanded(
                    //   child: RaisedButton(
                    //     onPressed: onJoin,
                    //     child: Text('Join'),
                    //     color: Colors.blueAccent,
                    //     textColor: Colors.white,
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCall(),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}