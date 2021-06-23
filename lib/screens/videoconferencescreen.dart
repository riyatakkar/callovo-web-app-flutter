import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_teams_clone/videoconference/createmeeting.dart';
import 'package:ms_teams_clone/videoconference/joinmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  buildtab(String name) {
    return Container(
      width: 150.0,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: GoogleFonts.oswald(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildtab("Join Meeting"),
            buildtab("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}
