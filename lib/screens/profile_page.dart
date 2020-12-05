import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kasettakorn/component/bottombar.dart';
import 'package:kasettakorn/screens/areaForm.dart';
import 'package:kasettakorn/screens/editProfile_page.dart';
import 'package:kasettakorn/styles/text.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Color(0xFFC4D923),
          flexibleSpace: FlexibleSpaceBar(
              title: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Users')
                      .document(widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (snapshot.data['img'] != null)
                                        ? NetworkImage(snapshot.data['img'])
                                        : NetworkImage(
                                            'https://i.pinimg.com/originals/2e/2f/ac/2e2fac9d4a392456e511345021592dd2.jpg',
                                          ),
                                    fit: BoxFit.cover),
                              ),
                            ),


                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      // child: Padding(
                                      //   padding: EdgeInsets.only(right: 50),
                                        child: ProfieTitleText('สวัสดี'),
                                      // ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: ProfieTitleText(
                                          snapshot.data['Username'],),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              centerTitle: true),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Card(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.edit, color: Colors.black),
                      title: TitleText('แก้ไขประวัติส่วนตัว'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfilePage(uid: widget.uid)));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.edit_location, color: Colors.black),
                    title: TitleText('แก้ไขข้อมูลพื้นที่ของคุณ'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AreaFormPage(uid: widget.uid)));
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.power_settings_new,
                      color: Colors.black,
                    ),
                    title: TitleText('ออกจากระบบ'),
                    onTap: () {
                      signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MyLoginPage()), (_) => false);
  }
}
