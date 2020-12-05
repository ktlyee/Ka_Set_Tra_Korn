import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kasettakorn/screens/suggestion_page.dart';
import 'package:kasettakorn/styles/colors.dart';

class AreaFormPage extends StatefulWidget {
  AreaFormPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _AreaFormPageState createState() => _AreaFormPageState();
}

class _AreaFormPageState extends State<AreaFormPage> {
  FirebaseUser currentUser;

  final _formKey = GlobalKey<FormState>();

  // TextEditingController sizeController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  String currentSize1;
  String currentSize2;
  String currentSize3;
  String regionSelected;
  String typeSelected;

  // String currentAddress;
  // ProvinceDao provinceSelected;

  final List<String> types = ['เลือก', 'ดินทราย', 'ดินเหนียว', 'ดินร่วน'];
  final List<String> regions = [
    'เลือก',
    'ภาคเหนือ',
    'ภาคตะวันออกเฉียงเหนือ',
    'ภาคกลาง',
    'ภาคตะวันออก',
    'ภาคใต้',
    'ภาคตะวันตก'
  ];

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
            "ข้อมูลพื้นที่ของคุณ",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
          backgroundColor: CollectionColors.lightgreen(),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[SizedBox(height: 30.0), _buildForm()],
        ))));
  }

  Widget _buildForm() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('Areas')
            .document(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading data");
          }
          var data = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 30.0),
                        child: Text(
                          "ขนาดพื้นที่",
                          style: TextStyle(
                              fontFamily: 'Kanit', color: Colors.black),
                        ))),
                SizedBox(height: 5.0),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 30.0),
                            width: 130.0,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      CollectionColors.gray().withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                      initialValue: data['ไร่'],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                      onChanged: (val) =>
                                          setState(() => currentSize1 = val)),
                                ))),
                        SizedBox(width: 5.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: Text(
                                  "ไร่",
                                  style: TextStyle(
                                      fontFamily: 'Kanit', color: Colors.black),
                                ))),
                      ]),
                      SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 30.0),
                            width: 130.0,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      CollectionColors.gray().withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                      initialValue: data['งาน'],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                      onChanged: (val) =>
                                          setState(() => currentSize2 = val)),
                                ))),
                        SizedBox(width: 5.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: Text(
                                  "งาน",
                                  style: TextStyle(
                                      fontFamily: 'Kanit', color: Colors.black),
                                ))),
                      ]),
                      SizedBox(height: 5.0),
                      Row(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 30.0),
                            width: 130.0,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      CollectionColors.gray().withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                      initialValue: data['วา'],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 16),
                                      onChanged: (val) =>
                                          setState(() => currentSize3 = val)),
                                ))),
                        SizedBox(width: 5.0),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 30.0),
                                child: Text(
                                  "ตารางวา",
                                  style: TextStyle(
                                      fontFamily: 'Kanit', color: Colors.black),
                                ))),
                      ]),
                    ])),
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 30.0),
                            child: Text(
                              "ภูมิภาค",
                              style: TextStyle(
                                  fontFamily: 'Kanit', color: Colors.black),
                            ))),
                    SizedBox(width: 25.0),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          color: CollectionColors.gray().withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: DropdownButton(
                                value: regionSelected ?? data['region'],
                                hint: Text("ภูมิภาคของประเทศไทย",
                                    style: TextStyle(fontFamily: 'Kanit')),
                                items: regions.map((region) {
                                  return DropdownMenuItem(
                                      value: region,
                                      child: Text(
                                        '$region',
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    regionSelected = value;
                                  });
                                })))
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 30.0),
                            child: Text(
                              "ประเภทของดิน",
                              style: TextStyle(
                                  fontFamily: 'Kanit', color: Colors.black),
                            ))),
                    SizedBox(width: 25.0),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          color: CollectionColors.gray().withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: DropdownButton(
                                value: typeSelected ?? data['soilType'],
                                hint: Text("ประเภทของดิน",
                                    style: TextStyle(fontFamily: 'Kanit')),
                                items: types.map((type) {
                                  return DropdownMenuItem(
                                      value: type,
                                      child: Text(
                                        '$type',
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    typeSelected = value;
                                  });
                                })))
                  ],
                ),
                SizedBox(height: 35.0),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints.expand(height: 50),
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Firestore.instance
                                    .collection("Areas")
                                    .document(currentUser.uid)
                                    // .collection('Area')
                                    .setData({
                                      "ไร่": currentSize1 ?? data['ไร่'],
                                      "งาน": currentSize2 ?? data['งาน'],
                                      "วา": currentSize3 ?? data['วา'],
                                      "region":
                                          regionSelected ?? data['region'],
                                      "soilType":
                                          typeSelected ?? data['soilType']
                                    })
                                    .then((result) => {Navigator.pop(context)})
                                    .catchError((err) => print(err));
                              }
                            },
                            color: CollectionColors.darkgreen(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              "บันทึก",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )),
                        SizedBox(width: 20),
                        RaisedButton(
                            onPressed: () => {Navigator.pop(context)},
                            color: CollectionColors.mediumbrown(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              "ยกเลิก",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                    margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                  ),
                )
              ]));
        });
  }
}
