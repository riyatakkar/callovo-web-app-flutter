import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataisthere = false;
  TextEditingController usernamecontroller = TextEditingController();
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
      dataisthere = true;
    });
  }

  editprofile() async {
    usercollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'username': usernamecontroller.text});
    setState(() {
      username = usernamecontroller.text;
    });
    Navigator.pop(context);
  }

  openeditprofiledialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200.0,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: usernamecontroller,
                      style: GoogleFonts.oswald(
                          fontSize: 18.0, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Update Username",
                        labelStyle: GoogleFonts.oswald(
                            fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  InkWell(
                    onTap: () => editprofile(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40.0,
                      decoration: BoxDecoration(color: Colors.redAccent),
                      child: Center(
                        child: Text(
                          "Update",
                          style: GoogleFonts.oswald(
                              fontSize: 17.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: dataisthere == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2 - 64,
                        top: MediaQuery.of(context).size.height / 3.1),
                    child: CircleAvatar(
                      radius: 64.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxEOnFyUwEDR1V0j-PQIQXw7oHEZ4jGdrrXjrW_hj-K52FWPD1uQvJPU0F2gdlLYjcqzc&usqp=CAU'),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300.0,
                        ),
                        Text(
                          username,
                          style: GoogleFonts.oswald(
                              fontSize: 40, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.0),
                        InkWell(
                          onTap: () => openeditprofiledialog(),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                "Edit Username",
                                style: GoogleFonts.oswald(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
