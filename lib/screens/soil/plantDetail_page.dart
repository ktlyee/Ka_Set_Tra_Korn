import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:provider/provider.dart';
import 'myPlant_page.dart';

class PlantDetail extends StatefulWidget {
  @override
  _PlantDetailState createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  FirebaseUser currentUser;

  @override
  initState() {
    this.getCurrentUser();
    this.benefit();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  String currentSize1;
  String currentSize2;
  String currentSize3;

  int total = 0;

  void benefit() {
    PlantNotifier plantNotifier =
        Provider.of<PlantNotifier>(context, listen: false);

    switch (plantNotifier.currentPlant.name) {
      case 'คะน้า':
        setState(() {
          total = 169107;
        });
        break;
      case 'ฟักทอง':
        setState(() {
          total = 676500;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier =
        Provider.of<PlantNotifier>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: CollectionColors.lightgreen(),
            title: Text(plantNotifier.currentPlant.name,
                style: TextStyle(
                    fontFamily: 'Chonburi',
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Image.network(
                      plantNotifier.currentPlant.img,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "ชื่อ : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.name,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "สภาพดินที่เหมาะสม : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.soil,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      Text(
                        "สภาพภูมิอากาศที่เหมาะสม : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.weather,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "ฤดูกาล : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.season,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "ระยะเวลาเพาะปลูก : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.period,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 15.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "วิธีการปลูก : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantNotifier.currentPlant.method,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "จำนวนที่ต้องการปลูก",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            fontFamily: 'Chonburi',
                            fontWeight: FontWeight.w400),
                      )),
                  SizedBox(height: 15.0),
                  Container(
                    margin: EdgeInsets.only(left: 60.0),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 180.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 130.0,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: CollectionColors.gray()
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: TextFormField(
                                                initialValue: '0',
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText: ""),
                                                style: TextStyle(
                                                    fontFamily: 'Chonburi',
                                                    fontSize: 30),
                                                textAlign: TextAlign.right,
                                                onChanged: (val) => setState(
                                                    () => currentSize1 = val)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "ไร่",
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: 180.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 130.0,
                                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: CollectionColors.gray()
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: TextFormField(
                                                  initialValue: '0',
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          hintText: ""),
                                                  style: TextStyle(
                                                      fontFamily: 'Chonburi',
                                                      fontSize: 30),
                                                  textAlign: TextAlign.right,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          currentSize2 = val)),
                                            )),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "งาน",
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: 180.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 130.0,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: CollectionColors.gray()
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: TextFormField(
                                                initialValue: '0',
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText: ""),
                                                style: TextStyle(
                                                    fontFamily: 'Chonburi',
                                                    fontSize: 30),
                                                textAlign: TextAlign.right,
                                                onChanged: (val) => setState(
                                                    () => currentSize3 = val)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "ตร.วา",
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  InkWell(
                      child: ButtonTheme(
                          minWidth: 280.0,
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('Areas')
                                    .document(currentUser.uid)
                                    .collection('Plants')
                                    .document(plantNotifier.currentPlant.id)
                                    .setData({
                                  "id": plantNotifier.currentPlant.id,
                                  "name": plantNotifier.currentPlant.name,
                                  "period": plantNotifier.currentPlant.period,
                                  "soil": plantNotifier.currentPlant.soil,
                                  "season": plantNotifier.currentPlant.season,
                                  "month": plantNotifier.currentPlant.month,
                                  "weather": plantNotifier.currentPlant.weather,
                                  "method": plantNotifier.currentPlant.method,
                                  "category":
                                      plantNotifier.currentPlant.category,
                                  "img": plantNotifier.currentPlant.img,
                                  "rai":
                                      currentSize1 == null ? "0" : currentSize1,
                                  "ngaan":
                                      currentSize2 == null ? "0" : currentSize2,
                                  "wa":
                                      currentSize3 == null ? "0" : currentSize3,
                                  "total": total,
                                }).then((result) => {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MyPlantPage(
                                                            uid: currentUser
                                                                .uid)),
                                          )
                                        });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: CollectionColors.darkgreen(),
                              child: Text(
                                "ปลูกพืชชนิดนี้",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ))))
                ]))));
  }
}
