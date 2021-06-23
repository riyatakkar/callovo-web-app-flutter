import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../variables.dart';

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
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username = userdoc['username'];
    });
  }

  joinmeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      var options = JitsiMeetingOptions(room: roomcontroller.text)
        ..userDisplayName =
            namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoOff
        ..featureFlags.addAll(featureflags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      "Name (Leave it blank if you want your username as your display name in the meeting)",
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
