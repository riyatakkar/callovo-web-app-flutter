import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_teams_clone/screens/registerscreen.dart';

import 'loginscreen.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        backgroundColor: Colors.deepPurple[100],
        title: Center(
          child: Text(
            "Callovo",
            style: GoogleFonts.allan(
              color: Colors.purpleAccent,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ),
            ),
            child: Container(
              width: 100.0,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text(
                  "SIGN UP",
                  style:
                      GoogleFonts.openSans(fontSize: 12.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: Row(
              children: [
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Live Video Calling &\nChat With ',
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          color: Colors.indigo[900],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Callovo\n",
                            style: GoogleFonts.allan(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Working from home? Or want to keep in touch\nwith friends? Keep your conversation going no\nmatter where you are.",
                            style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                      child: Container(
                        width: 250.0,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            "SIGN IN",
                            style: GoogleFonts.openSans(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 180.0,
                ),
                Image.network(
                  "https://media.istockphoto.com/photos/cropped-image-of-businessman-using-laptop-at-desk-picture-id1216652501?k=6&m=1216652501&s=612x612&w=0&h=1QGaPMF447CZPhtGugXsYbBt6cMyonFUtlPvdwnH4ok=",
                  width: 600.0,
                  height: 500.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
