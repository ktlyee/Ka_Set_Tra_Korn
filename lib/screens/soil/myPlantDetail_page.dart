import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/model/plant.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:provider/provider.dart';

class MyPlantDetail extends StatefulWidget {
  MyPlantDetail({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _MyPlantDetail createState() => _MyPlantDetail();
}

class _MyPlantDetail extends State<MyPlantDetail> {
  FirebaseUser currentUser;

  @override
  initState() {
    this.benefit();
    this.getCurrentUser();
    super.initState();
    // this.storeBenefit();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  String rai;
  String ngaan;
  String wa;

  double raiToRai = 0, ngaanToRai = 0, waToRai = 0, perRai = 0;
  int total = 0;

  void deleteMyPlant(MyPlant myPlant, Function myPlantDeleted) async {
    await Firestore.instance
        .collection('Areas')
        .document(currentUser.uid)
        .collection('Plants')
        .document(myPlant.id)
        .delete();
    myPlantDeleted(myPlant);
  }

  void storeBenefit() {
    MyPlantNotifier myPlantNotifier =
        Provider.of<MyPlantNotifier>(context, listen: false);
    Firestore.instance
        .collection('Areas')
        .document(currentUser.uid)
        .collection('Plants')
        .document(myPlantNotifier.currentMyPlant.id)
        .updateData({"total": total});
  }

  void benefit() {
    double a = 0, b = 0;

    MyPlantNotifier myPlantNotifier =
        Provider.of<MyPlantNotifier>(context, listen: false);

    String raiDb = myPlantNotifier.currentMyPlant.rai;
    String ngaanDb = myPlantNotifier.currentMyPlant.ngaan;
    String waDb = myPlantNotifier.currentMyPlant.wa;

    a = double.parse(ngaanDb);
    b = double.parse(waDb);

    switch (myPlantNotifier.currentMyPlant.name) {
      case 'คะน้า':
        setState(() {
          raiToRai = double.parse(raiDb);
          ngaanToRai = a / 4;
          waToRai = b / 400;
          perRai = 67643;
          total = ((raiToRai + ngaanToRai + waToRai) * perRai).floor();
          // storeBenefit();
        });
        break;
      case 'ฟักทอง':
        setState(() {
          raiToRai = double.parse(raiDb);
          ngaanToRai = a / 4;
          waToRai = b / 400;
          perRai = 45000;
          total = ((raiToRai + ngaanToRai + waToRai) * perRai).floor();
          // storeBenefit();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    MyPlantNotifier myPlantNotifier =
        Provider.of<MyPlantNotifier>(context, listen: false);

    _onMyPlantDeleted(MyPlant myPlant) {
      Navigator.of(context).pop();
      myPlantNotifier.deleteMyPlant(myPlant);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: CollectionColors.lightgreen(),
            title: Text(myPlantNotifier.currentMyPlant.name,
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
                      myPlantNotifier.currentMyPlant.img,
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
                        myPlantNotifier.currentMyPlant.name,
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
                        myPlantNotifier.currentMyPlant.soil,
                        style: TextStyle(
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                    // alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      Text(
                        "สภาพภูมิอากาศที่เหมาะสม : ",
                        style: TextStyle(
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        myPlantNotifier.currentMyPlant.weather,
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
                        myPlantNotifier.currentMyPlant.season,
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
                        myPlantNotifier.currentMyPlant.period,
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
                        "วิธีการปลูก : ",
                        style: TextStyle(
                            fontFamily: 'Kanit', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        myPlantNotifier.currentMyPlant.method,
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
                    margin: EdgeInsets.only(
                      left: 80.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Center(
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width: 200.0,
                                    child: Row(children: <Widget>[
                                      DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: CollectionColors.gray()
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 5.0, 10.0, 5.0),
                                              child: Text(
                                                myPlantNotifier
                                                    .currentMyPlant.rai,
                                                style: TextStyle(
                                                    fontFamily: 'Chonburi',
                                                    fontSize: 30),
                                              ))),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "ไร่",
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ),
                                    ])),
                                SizedBox(height: 20.0),
                                Container(
                                    width: 200.0,
                                    child: Row(children: <Widget>[
                                      DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: CollectionColors.gray()
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 5.0, 10.0, 5.0),
                                              child: Text(
                                                myPlantNotifier
                                                    .currentMyPlant.ngaan,
                                                style: TextStyle(
                                                    fontFamily: 'Chonburi',
                                                    fontSize: 30),
                                              ))),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "งาน",
                                        style: TextStyle(fontFamily: 'Kanit'),
                                      ),
                                    ])),
                                SizedBox(height: 20.0),
                                Container(
                                  width: 200.0,
                                  child: Row(
                                    children: <Widget>[
                                      DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: CollectionColors.gray()
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10.0, 5.0, 10.0, 5.0),
                                              child: Text(
                                                myPlantNotifier
                                                    .currentMyPlant.wa,
                                                style: TextStyle(
                                                    fontFamily: 'Chonburi',
                                                    fontSize: 30),
                                              ))),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 2.0,
                      width: 300.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "ราคาคาดการณ์",
                            style: TextStyle(
                              fontFamily: 'Chonburi',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          // ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ActiclePageText(
                            "$total บาท",
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "* ราคาผลผลิตต่อไร่ประมาณ $perRai บาท *",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "* ราคาทั้งหมดนี้เป็นเพียงค่าประมาณ *",
                            style: TextStyle(
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                      child: ButtonTheme(
                          minWidth: 280.0,
                          height: 50.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: RaisedButton(
                              onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0)), //this right here
                                            child: Container(
                                              height: 350.0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(height: 20.0),
                                                    Text(
                                                      "แก้ไขพื้นที่ที่จะปลูก",
                                                      textScaleFactor: 1.3,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Chonburi',
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(height: 25.0),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                30.0),
                                                                        width:
                                                                            100.0,
                                                                        child: DecoratedBox(
                                                                            decoration: BoxDecoration(
                                                                              color: CollectionColors.gray().withOpacity(0.3),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10.0),
                                                                              child: TextFormField(initialValue: myPlantNotifier.currentMyPlant.rai, keyboardType: TextInputType.number, decoration: InputDecoration.collapsed(hintText: ""), style: TextStyle(fontFamily: 'Kanit', fontSize: 16), onChanged: (val) => setState(() => myPlantNotifier.currentMyPlant.rai = val)),
                                                                            ))),
                                                                    SizedBox(
                                                                        width:
                                                                            5.0),
                                                                    Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: 30.0),
                                                                            child: Text(
                                                                              "ไร่",
                                                                              style: TextStyle(fontFamily: 'Kanit', color: Colors.black),
                                                                            ))),
                                                                  ]),
                                                              SizedBox(
                                                                  height: 5.0),
                                                              Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                30.0),
                                                                        width:
                                                                            100.0,
                                                                        child: DecoratedBox(
                                                                            decoration: BoxDecoration(
                                                                              color: CollectionColors.gray().withOpacity(0.3),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10.0),
                                                                              child: TextFormField(initialValue: myPlantNotifier.currentMyPlant.ngaan, keyboardType: TextInputType.number, decoration: InputDecoration.collapsed(hintText: ""), style: TextStyle(fontFamily: 'Kanit', fontSize: 16), onChanged: (val) => setState(() => myPlantNotifier.currentMyPlant.ngaan = val)),
                                                                            ))),
                                                                    SizedBox(
                                                                        width:
                                                                            5.0),
                                                                    Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: 30.0),
                                                                            child: Text(
                                                                              "งาน",
                                                                              style: TextStyle(fontFamily: 'Kanit', color: Colors.black),
                                                                            ))),
                                                                  ]),
                                                              SizedBox(
                                                                  height: 5.0),
                                                              Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                30.0),
                                                                        width:
                                                                            100.0,
                                                                        child: DecoratedBox(
                                                                            decoration: BoxDecoration(
                                                                              color: CollectionColors.gray().withOpacity(0.3),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(left: 10.0),
                                                                              child: TextFormField(initialValue: myPlantNotifier.currentMyPlant.wa, keyboardType: TextInputType.number, decoration: InputDecoration.collapsed(hintText: ""), style: TextStyle(fontFamily: 'Kanit', fontSize: 16), onChanged: (val) => setState(() => myPlantNotifier.currentMyPlant.wa = val)),
                                                                            ))),
                                                                    SizedBox(
                                                                        width:
                                                                            5.0),
                                                                    Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: 30.0),
                                                                            child: Text(
                                                                              "ตารางวา",
                                                                              style: TextStyle(fontFamily: 'Kanit', color: Colors.black),
                                                                            ))),
                                                                  ]),
                                                            ])),
                                                    SizedBox(height: 25.0),
                                                    InkWell(
                                                      child: Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 31.0,
                                                          ),
                                                          ButtonTheme(
                                                            minWidth: 200.0,
                                                            height: 40.0,
                                                            child: RaisedButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                              ),
                                                              onPressed: () => {
                                                                Firestore
                                                                    .instance
                                                                    .collection(
                                                                        'Areas')
                                                                    .document(
                                                                        currentUser
                                                                            .uid)
                                                                    .collection(
                                                                        'Plants')
                                                                    .document(
                                                                        myPlantNotifier
                                                                            .currentMyPlant
                                                                            .id)
                                                                    .updateData({
                                                                  "rai": myPlantNotifier
                                                                      .currentMyPlant
                                                                      .rai,
                                                                  "ngaan": myPlantNotifier
                                                                      .currentMyPlant
                                                                      .ngaan,
                                                                  "wa": myPlantNotifier
                                                                      .currentMyPlant
                                                                      .wa,
                                                                }).then((result) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  benefit();
                                                                  storeBenefit();
                                                                })
                                                              },
                                                              color: CollectionColors
                                                                  .mediumbrown(),
                                                              child: Text(
                                                                "บันทึกการเปลี่ยนแปลง",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                textScaleFactor:
                                                                    1.2,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Kanit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  },
                              color: CollectionColors.mediumbrown(),
                              child: Text(
                                "แก้ไขพื้นที่",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )))),
                  SizedBox(height: 20.0),
                  InkWell(
                      child: ButtonTheme(
                          minWidth: 280.0,
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15.0)), //this right here
                                        child: Container(
                                          height: 200,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10)),
                                                Text(
                                                  "ยินดีด้วยคุณปลูกพืชนี้สำเร็จแล้ว",
                                                  textScaleFactor: 1.3,
                                                  style: TextStyle(
                                                      fontFamily: 'Chonburi'),
                                                ),
                                                Text(
                                                  "กดตกลงเพื่อนำพืชออกจากรายการพืชที่กำลังปลูก",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit'),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                    ),
                                                    SizedBox(
                                                      width: 80.0,
                                                      child: RaisedButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          onPressed: () {
                                                            deleteMyPlant(
                                                                myPlantNotifier
                                                                    .currentMyPlant,
                                                                _onMyPlantDeleted);
                                                          },
                                                          child: Text(
                                                            "ตกลง",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Kanit'),
                                                          ),
                                                          color:
                                                              CollectionColors
                                                                  .darkgreen()),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 80.0,
                                                      child: RaisedButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "ยกเลิก",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Kanit',
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color:
                                                              CollectionColors
                                                                  .darkbrown()),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: CollectionColors.darkgreen(),
                              child: Text(
                                "ปลูกพืชสำเร็จแล้ว",
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
