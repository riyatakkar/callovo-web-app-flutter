// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

import '../variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
            ),
            child: Center(
              child: Text(
                "Callovo",
                style: GoogleFonts.allan(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: GoogleFonts.oswald(
                          fontSize: 18.0, color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        hintStyle: GoogleFonts.oswald(
                            fontSize: 18.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: GoogleFonts.oswald(
                          fontSize: 18.0, color: Colors.black),
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        hintStyle: GoogleFonts.oswald(
                            fontSize: 18.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      style: GoogleFonts.oswald(
                          fontSize: 18.0, color: Colors.black),
                      controller: usernamecontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
                        hintStyle: GoogleFonts.oswald(
                            fontSize: 18.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text,
                                password: passwordcontroller.text)
                            .then((signeduser) {
                          usercollection.doc(signeduser.user!.uid).set({
                            'username': usernamecontroller.text,
                            'email': emailcontroller.text,
                            'password': passwordcontroller.text,
                            'uid': signeduser.user!.uid,
                          });
                        });
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                        var snackbar = SnackBar(
                            content: Text(
                          e.toString(),
                          style: GoogleFonts.oswald(fontSize: 20.0),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.indigo[900],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          style: GoogleFonts.oswald(
                              fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
