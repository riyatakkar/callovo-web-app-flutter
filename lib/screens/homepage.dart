import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_teams_clone/screens/profilescreen.dart';
import 'package:ms_teams_clone/screens/videoconferencescreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [
    VideoConferenceScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[100],
        selectedItemColor: Colors.blue,
        selectedLabelStyle:
            GoogleFonts.oswald(fontSize: 17, color: Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle:
            GoogleFonts.oswald(fontSize: 17, color: Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Video Call",
            icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person, size: 32),
          ),
        ],
      ),
      body: pageoptions[page],
    );
  }
}
