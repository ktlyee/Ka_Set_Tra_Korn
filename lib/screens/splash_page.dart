import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:kasettakorn/component/bottombar.dart';
import 'package:kasettakorn/screens/login_page.dart';
import 'package:kasettakorn/styles/colors.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyLoginPage()))
                }
              else
                {
                  Firestore.instance
                      .collection("Users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomBar(uid: currentUser.uid))))
                      .catchError((error) => print(error))
                }
            })
        .catchError((error) => print(error));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CollectionColors.lightgreen(),
      body: Center(
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Image.asset('assets/images/logo-white.png',
                  width: 250.0, height: 250.0),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                "กะ-เสด-ตระ-กอน",
                textAlign: TextAlign.center,
                textScaleFactor: 2.5,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Chonburi',
                    color: Colors.white),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "แอปพลิเคชั่นสำหรับเกษตรกร",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.5,
                  style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
                ))
          ],
        )),
      ),
    );
  }
}
