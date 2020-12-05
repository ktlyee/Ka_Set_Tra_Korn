import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:uuid/uuid.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseUser currentUser;

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  String _currentUsename;
  String _currentEmail;

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "แก้ไขประวัติส่วนตัว",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
          backgroundColor: CollectionColors.lightgreen(),
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              SizedBox(height: 20.0),
              _buildTextFieldsAndButton(),
            ])));
  }

  uploadImage(BuildContext context) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // select img
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      var uuid = Uuid().v4();

      if (image != null) {
        //upload img
        var snapshot = await _storage
            .ref()
            .child('user_pic/$uuid')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Profile picture upload')));
          Firestore.instance
              .collection('Users')
              .document(currentUser.uid)
              .updateData({
            "img": imageUrl,
          });
        });
      } else {
        print('No path Received');
      }
    } else {
      print('Grant permissions and try again');
    }
  }

  Widget _buildTextFieldsAndButton() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Users')
            .document(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading data...");
          }
          var data = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 150.0,
                                  width: 150.0,
                                  child: (data['img'] != null)
                                      ? Image.network(data['img'],
                                          fit: BoxFit.fill)
                                      : Image.network(
                                          'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0, top: 120),
                            child: Row(
                              children: <Widget>[
                                // CircleAvatar(
                                //   backgroundColor: CollectionColors.gray(),
                                // child:
                                Align(
                                  alignment: Alignment.center,
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    color: CollectionColors.lightbrown(),
                                    child: IconButton(
                                        icon: Icon(
                                          MaterialIcons.camera_alt,
                                          size: 30.0,
                                          // color: Colors.white
                                          color: Colors.white,
                                        ),
                                        highlightColor: CollectionColors.gray(),
                                        onPressed: () {
                                          uploadImage(context);
                                        }),
                                  ),
                                ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Username",
                            style: TextStyle(
                                fontFamily: 'Kanit', color: Colors.black),
                          ))),
                  SizedBox(height: 5.0),
                  Container(
                      margin: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: CollectionColors.gray().withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                                initialValue: data['Username'],
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                                style: TextStyle(
                                    fontFamily: 'Kanit', fontSize: 16),
                                validator: (val) =>
                                    val.isEmpty ? 'โปรดระบุ username' : null,
                                onChanged: (val) =>
                                    setState(() => _currentUsename = val)),
                          ))),
                  SizedBox(height: 10.0),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: Text(
                            "E-mail",
                            style: TextStyle(
                                fontFamily: 'Kanit', color: Colors.black),
                          ))),
                  SizedBox(height: 5.0),
                  Container(
                      margin: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: CollectionColors.gray().withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                                initialValue: data['Email'],
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                                style: TextStyle(
                                    fontFamily: 'Kanit', fontSize: 16),
                                validator: (val) =>
                                    val.isEmpty ? 'โปรดระบุ E-mail' : null,
                                onChanged: (val) =>
                                    setState(() => _currentEmail = val)),
                          ))),
                  SizedBox(height: 20.0),
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                color: CollectionColors.darkgreen(),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await Firestore.instance
                                        .collection('Users')
                                        .document(currentUser.uid)
                                        .updateData({
                                      "Username":
                                          _currentUsename ?? data['Username'],
                                      "Email": _currentEmail ?? data['Email'],
                                      // "img": imageUrl ?? data['img']
                                    }).then((value) => setState(() {
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Update data successful')));
                                            }));
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 4.0,
                                child: Text(
                                  "บันทึก",
                                  style: TextStyle(
                                      fontFamily: 'Kanit', color: Colors.black),
                                )),
                            RaisedButton(
                                color: CollectionColors.darkbrown(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 4.0,
                                child: Text(
                                  "ยกเลิก",
                                  style: TextStyle(
                                      fontFamily: 'Kanit', color: Colors.white),
                                ))
                          ]))
                ],
              ));
        });
  }
}
