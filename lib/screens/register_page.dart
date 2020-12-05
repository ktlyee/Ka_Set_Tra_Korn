import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kasettakorn/component/bottombar.dart';
import 'package:kasettakorn/styles/colors.dart';

class MyRegisterPage extends StatefulWidget {
  MyRegisterPage({Key key}) : super(key: key);

  @override
  _MyRegisterPageState createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
            child: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildRegisterText(),
                  buildTextFieldUsername(),
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildTextFieldPasswordConfirm(),
                  buildButtonSignUp(context),
                  // buildOtherLine(),
                  // buildButtonGoogle(context),
                ],
              )),
        )));
  }

  Widget buildRegisterText() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Image.asset('assets/images/logo-green.png',
                width: 100.0, height: 100.0),
          ),
          Text(
            "กะ-เสด-ตระ-กอน",
            textAlign: TextAlign.center,
            textScaleFactor: 2.0,
            style: TextStyle(
                fontFamily: 'Chonburi', color: CollectionColors.darkbrown()),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20.0),
    );
  }

  Widget buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
      constraints: BoxConstraints.expand(height: 50),
      child: RaisedButton(
        onPressed: () => {signUp()},
        color: CollectionColors.darkgreen(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text("ลงทะเบียน",
            textAlign: TextAlign.center,
            textScaleFactor: 1.3,
            style: TextStyle(
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w200,
                color: Colors.black)),
      ),
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      margin: EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 10.0),
    ));
  }

  Container buildTextFieldUsername() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      decoration: BoxDecoration(
          color: CollectionColors.gray(),
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
          controller: usernameController,
          decoration: InputDecoration.collapsed(hintText: "Username"),
          style: TextStyle(fontFamily: 'Kanit', fontSize: 16)),
    );
  }

  Container buildTextFieldEmail() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: BoxDecoration(
            color: CollectionColors.gray(),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16)));
  }

  Container buildTextFieldPassword() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: BoxDecoration(
            color: CollectionColors.gray(),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16)));
  }

  Container buildTextFieldPasswordConfirm() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: BoxDecoration(
            color: CollectionColors.gray(),
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Confirm Password"),
            style: TextStyle(fontFamily: 'Kanit', fontSize: 16)));
  }

  // Widget buildOtherLine() {
  //   return Container(
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Divider(color: Color.fromRGBO(191, 108, 59, 1)),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.all(6),
  //           child: Text(
  //             "หรือ",
  //             textScaleFactor: 1.0,
  //             style: TextStyle(
  //                 fontFamily: 'Kanit', color: Color.fromRGBO(191, 108, 59, 1)),
  //           ),
  //         ),
  //         Expanded(
  //           child: Divider(color: Color.fromRGBO(191, 108, 59, 1)),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget buildButtonGoogle(BuildContext context) {
  //   return InkWell(
  //     child: Container(
  //       constraints: BoxConstraints.expand(height: 50),
  //       child: RaisedButton(
  //         onPressed: () => {loginWithGoogle(context)},
  //         color: CollectionColors.lightbrown(),
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Padding(
  //                 padding: EdgeInsets.only(left: 10.0, right: 10.0),
  //                 child: Image.asset('assets/images/google.png',
  //                     width: 20.0, height: 20.0)),
  //             Text("ลงทะเบียนด้วย Google",
  //                 textAlign: TextAlign.center,
  //                 textScaleFactor: 1.2,
  //                 style: TextStyle(fontFamily: 'Kanit', color: Colors.black)),
  //           ],
  //         ),
  //       ),
  //       margin: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 0),
  //     ),
  //   );
  // }

  signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (currentUser) => Firestore.instance
                .collection("Users")
                .document(currentUser.user.uid)
                .setData({
              "Uid": currentUser.user.uid,
              "Username": usernameController.text,
              "Email": emailController.text,
            }).then((result) => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomBar(uid: currentUser.user.uid)),
                          (_) => false),
                      Firestore.instance
                          .collection('Areas')
                          .document(currentUser.user.uid)
                          .setData({
                        "ไร่": '0',
                        "งาน": '0',
                        "วา": '0',
                        "region": 'เลือก',
                        "soilType": 'เลือก'
                      }),
                      usernameController.clear(),
                      emailController.clear(),
                      passwordController.clear(),
                      confirmPasswordController.clear()
                    }),
//        print("Sign up user successful");
//        checkAuth(context);
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
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "The passwords do not match",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

//  Future checkAuth(BuildContext context) async {
//    FirebaseUser user = await _auth.currentUser();
//    if(user != null) {
//      print("Already signed-up with");
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => MyHomePage(user))
//      );
//    }
//  }

  // Future loginWithGoogle(BuildContext context) async {
//    GoogleSignIn _googleSignIn = GoogleSignIn(
//        scopes: ['https://www.googleapis.com/auth/contacts.readonly']
//    );
//    GoogleSignInAccount user = await _googleSignIn.signIn();
//    GoogleSignInAuthentication userAuth =  await user.authentication;
//
//    await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.getCredential(
//        idToken: userAuth.idToken, accessToken: userAuth.accessToken
//    ));
//    checkAuth(context);

//    bool isSigned = await _googleSignIn.isSignedIn();
//    if(isSigned){
//      await _googleSignIn.signOut();
//    }
  // }
}
