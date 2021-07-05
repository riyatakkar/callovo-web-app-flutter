import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoOff = true;
  bool isAudioMuted = true;
  String username = '';

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  joinmeeting() async {
    var options = JitsiMeetingOptions(room: roomcontroller.text)
      ..serverURL = "https://meet.jit.si"
      ..webOptions = {
        "width": "100%",
        "height": "100%",
        "userInfo": {
          "displayName":
              namecontroller.text == '' ? username : namecontroller.text
        }
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.30,
                      child: meetConfig(),
                    ),
                    Container(
                        width: width * 0.60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.white54,
                              child: SizedBox(
                                width: width * 0.60 * 0.70,
                                height: width * 0.60 * 0.70,
                                child: JitsiMeetConferencing(
                                  extraJS: [
                                    // extraJs setup example
                                    '<script>function echo(){console.log("echo!!!")};</script>',
                                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                  ],
                                ),
                              )),
                        ))
                  ],
                )
              : meetConfig(),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Enter code",
                style: GoogleFonts.oswald(fontSize: 20),
              ),
              SizedBox(
                height: 20.0,
              ),
              PinCodeTextField(
                appContext: context,
                controller: roomcontroller,
                length: 5,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                ),
                animationDuration: Duration(milliseconds: 300),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: namecontroller,
                style: GoogleFonts.oswald(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      "Name (Leave blank if you want your username as your display name)",
                  labelStyle: GoogleFonts.oswald(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                value: isVideoOff,
                onChanged: (value) {
                  setState(() {
                    isVideoOff = value!;
                  });
                },
                title: Text(
                  "Video Off",
                  style: GoogleFonts.oswald(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value!;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: GoogleFonts.oswald(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "(You can also customise your settings after joining the meeting)",
                style: GoogleFonts.oswald(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinmeeting(),
                child: Container(
                  width: double.maxFinite,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style:
                          GoogleFonts.oswald(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
