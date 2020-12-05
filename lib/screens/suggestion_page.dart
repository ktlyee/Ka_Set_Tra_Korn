import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/screens/calculator_page.dart';
import 'package:kasettakorn/screens/areaForm.dart';
import 'package:kasettakorn/screens/soil/myPlant_page.dart';
import 'package:kasettakorn/screens/soil/suggestionPlant_page.dart';
import 'package:kasettakorn/styles/colors.dart';

class SuggestionPage extends StatefulWidget {
  SuggestionPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  FirebaseUser currentUser;

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "แนะนำเกี่ยวกับการเกษตร",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
          backgroundColor: CollectionColors.lightgreen(),
        ),
        body: new StreamBuilder(
            stream: Firestore.instance
                .collection('Areas')
                .document(widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading data...");
              }
              var detail = snapshot.data;
              return Center(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    width: 320.0,
                    height: 220.0,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: CollectionColors.gray().withOpacity(1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0, 3))
                            ]),
                        child: Container(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ข้อมูลพื้นที่ของคุณ",
                                        textScaleFactor: 1.3,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Chonburi',
                                            color: Colors.black),
                                      ),
                                    )),
                                SizedBox(height: 15.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        "ขนาดพื้นที่: ",
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(height: 6.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        detail['ไร่'] + " " + "ไร่",
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: Colors.black),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        detail['งาน'] + " " + "งาน",
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: Colors.black),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 50.0),
                                      child: Text(
                                        detail['วา'] + " " + "ตารางวา",
                                        textScaleFactor: 1.0,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Kanit',
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(height: 6.0),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(left: 30.0),
                                        child: Text(
                                          "ภูมิภาค: " + detail['region'],
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: Colors.black),
                                        ))),
                                SizedBox(height: 6.0),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.only(left: 30.0),
                                        child: Text(
                                          "ลักษณะของดิน: " + detail['soilType'],
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontFamily: 'Kanit',
                                              color: Colors.black),
                                        ))),
                              ],
                            ))),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                              onPressed: () {
                                handleRouting(detail);
                              },
                              color: CollectionColors.gray().withOpacity(1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "พืชแนะนำของคุณ",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontFamily: 'Chonburi',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )),
                                SizedBox(width: 105.0),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.black,
                                  size: 30.0,
                                )
                              ])))),
                  SizedBox(height: 20.0),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MyPlantPage(uid: currentUser.uid)));
                              },
                              color: CollectionColors.gray().withOpacity(1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "พืชที่กำลังปลูก",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontFamily: 'Chonburi',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )),
                                SizedBox(width: 130.0),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.black,
                                  size: 30.0,
                                )
                              ])))),
                  SizedBox(height: 20.0),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CalculatorPage()));
                              },
                              color: CollectionColors.gray().withOpacity(1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "คำนวณพื้นที่ของคุณ",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontFamily: 'Chonburi',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )),
                                SizedBox(width: 75.0),
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.black,
                                  size: 30.0,
                                )
                              ])))),
                ],
              ));
            }));
  }

  void handleRouting(dynamic detail) {
    switch (detail['soilType']) {
      case 'ดินเหนียว':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                SuggestionPlantPage(soilType: 'ดินเหนียว')));
        break;
      case 'ดินร่วน':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                SuggestionPlantPage(soilType: 'ดินร่วน')));
        break;
      case 'ดินทราย':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                SuggestionPlantPage(soilType: 'ดินทราย')));
        break;
      case 'เลือก':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                AreaFormPage(uid: currentUser.uid)));
    }
  }
}
