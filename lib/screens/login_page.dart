import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kasettakorn/component/bottombar.dart';
import 'package:kasettakorn/screens/home_page.dart';
import 'package:kasettakorn/screens/register_page.dart';
import 'package:kasettakorn/styles/colors.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CollectionColors.lightgreen(),
      body: Container(
          child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildSignInText(),
              buildTextFieldEmail(),
              buildTextFieldPassword(),
              buildButtonSignIn(),
              buildOtherLine(),
              // buildButtonGoogle(context),
              buildButtonRegister(),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildSignInText() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Image.asset(
              'assets/images/logo-white.png',
              width: 100.0,
              height: 100.0,
            ),
          ),
          Text(
            "กะ-เสด-ตระ-กอน",
            textAlign: TextAlign.center,
            textScaleFactor: 2.0,
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.white),
          ),
          Text(
            "แอปพลิเคชั่นสำหรับเกษตรกร",
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
            style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20.0),
    );
  }

  Widget buildButtonSignIn() {
    return InkWell(
      child: Container(
        constraints: BoxConstraints.expand(height: 50),
        child: RaisedButton(
            onPressed: () => {signIn()},
            color: Color.fromRGBO(242, 242, 242, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              "เข้าสู่ระบบ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )),
        padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
        margin: EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
      ),
    );
  }

  Container buildTextFieldEmail() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                spreadRadius: 0.0,
                offset: Offset(0, 3))
          ]),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration.collapsed(hintText: "E-mail"),
        style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
      ),
    );
  }

  Container buildTextFieldPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                spreadRadius: 0.0,
                offset: Offset(0, 3))
          ]),
      child: TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration.collapsed(hintText: "Password"),
        style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
      ),
    );
  }

  Widget buildOtherLine() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              "หรือ",
              textScaleFactor: 1.0,
              style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.white),
          )
        ],
      ),
    );
  }

  // Widget buildButtonGoogle(BuildContext context) {
  //   return InkWell(
  //     child: Container(
  //       constraints: BoxConstraints.expand(height: 50),
  //       child: RaisedButton(
  //         onPressed: () => {loginWithGoogle(context)},
  //         color: Color.fromRGBO(217, 26, 26, 1),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Padding(
  //                 padding: EdgeInsets.only(left: 10.0, right: 10.0),
  //                 child: Image.asset('assets/images/google.png',
  //                     width: 20.0, height: 20.0)),
  //             Text(
  //               "เข้าสู่ระบบด้วย Google",
  //               textAlign: TextAlign.center,
  //               textScaleFactor: 1.2,
  //               style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //       margin: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0),
  //     ),
  //   );
  // }

  Widget buildButtonRegister() {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ถ้าคุณยังไม่มีบัญชี",
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
              style: TextStyle(fontFamily: 'Kanit', color: Colors.white),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyRegisterPage()));
              },
              child: Text(
                "ลงทะเบียน",
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        margin: EdgeInsets.only(top: 20, left: 19.5),
      ),
    );
  }

  // Future checkAuth(BuildContext context) async {
  //   FirebaseUser user = await _auth.currentUser();
  //   if (user != null) {
  //     print("Already signed-in with");
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => BottomBar(user)));
  //   }
  // }

  Future<FirebaseUser> signIn() async {
    await _auth
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then(
          (currentUser) => Firestore.instance
              .collection("Users")
              .document(currentUser.user.uid)
              .get()
              .then((DocumentSnapshot result) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomBar(
                            uid: currentUser.user.uid,
                          )),
                  (_) => false)),
//      print("signed in ${user.user.email}");
//      checkAuth(context);
        )
        .catchError((error) {
      print(error.message);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          error.message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    });
  }

  // Future loginWithGoogle(BuildContext context) async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['https://www.googleapis.com/auth/contacts.readonly']);
  //   GoogleSignInAccount user = await _googleSignIn.signIn();
  //   GoogleSignInAuthentication userAuth = await user.authentication;

  //   await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
  //       idToken: userAuth.idToken, accessToken: userAuth.accessToken));
  //   checkAuth(context);
  //   bool isSigned = await _googleSignIn.isSignedIn();
  //   if (isSigned) {
  //     await _googleSignIn.signOut();
  //   }
  // }
}
