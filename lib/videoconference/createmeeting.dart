import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreateMeeting extends StatefulWidget {
  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';

  createcode() {
    setState(() {
      code = Uuid().v1().substring(0, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "Create a code and share it with others.",
              style: GoogleFonts.oswald(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code: ",
                style: GoogleFonts.oswald(fontSize: 30.0),
              ),
              Text(
                code,
                style: GoogleFonts.oswald(
                  fontSize: 30.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          InkWell(
            onTap: () => createcode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple[800],
              ),
              child: Center(
                child: Text(
                  "Create Code",
                  style:
                      GoogleFonts.oswald(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
