import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';

import '../component/bottombar.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final List<String> units = ['หน่วย', 'ไร่', 'งาน', 'ตารางวา'];

  int sum = 0, rai = 0, ngaan = 0, wa = 0, amount = 0;
  int a = 0, b = 0;

  final TextEditingController num = new TextEditingController(text: "0");

  String unitFrom = 'หน่วย';
  String unitTo = 'หน่วย';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "คำนวณพื้นที่ของคุณ",
          style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
        ),
        backgroundColor: CollectionColors.lightgreen(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            //*******************ส่วนที่เลือกหน่วยที่ต้องการแปลง
            Row(
              children: <Widget>[
                Align(
                    // alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.only(left: 30.0),
                        child: Text(
                          "แปลงจาก",
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              color: Colors.black,
                              fontSize: 18),
                        ))),
                SizedBox(width: 15.0),
                DecoratedBox(
                    decoration: BoxDecoration(
                      color: CollectionColors.lightbrown().withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton(
                            value: unitFrom,
                            hint:
                                Text("", style: TextStyle(fontFamily: 'Kanit')),
                            items: units.map((unit) {
                              return DropdownMenuItem(
                                  value: unit,
                                  child: Text(
                                    '$unit',
                                    style: TextStyle(fontFamily: 'Kanit'),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                unitFrom = value;
                              });
                            }))),
              ],
            ),
            //*******************จบส่วนที่เลือกหน่วยที่ต้องการแปลง
            SizedBox(height: 15.0),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Row(children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      width: 230.0,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: CollectionColors.gray().withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: TextField(
                              controller: num,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration.collapsed(hintText: "0"),
                              style: TextStyle(
                                  fontFamily: 'Kanit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.right,
                              // onChanged: (val) => setState(() => num = val)
                            ),
                          ))),
                ),
                SizedBox(width: 10.0),
                Align(
                    // alignment: Alignment.center,
                    child: Container(
                        // margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                  unitFrom,
                  style: TextStyle(
                      fontFamily: 'Kanit', color: Colors.black, fontSize: 15),
                  textAlign: TextAlign.right,
                ))),
              ]),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 2.0,
                width: 300.0,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            SizedBox(height: 15.0),
            Row(children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: Text(
                        "ไป",
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            color: Colors.black,
                            fontSize: 18),
                      ))),
              SizedBox(width: 15.0),
              DecoratedBox(
                  decoration: BoxDecoration(
                    color: CollectionColors.lightbrown().withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButton(
                          value: unitTo,
                          hint: Text("หน่วย",
                              style: TextStyle(fontFamily: 'Kanit')),
                          items: units.map((unit) {
                            return DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  '$unit',
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              unitTo = value;
                            });
                          }))),
            ]),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(right: 40.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: Text(
                        "คำตอบ",
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            color: Colors.black,
                            fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: CalculateText(
                        "$rai ไร่",
                        // style:
                        //     TextStyle(fontFamily: 'Kanit', color: Colors.black),
                        // textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: CalculateText(
                        "$ngaan งาน",
                        // style:
                        //     TextStyle(fontFamily: 'Kanit', color: Colors.black),
                        // textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: CalculateText(
                        "$wa ตารางวา",
                        // style:
                        //     TextStyle(fontFamily: 'Kanit', color: Colors.black),
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
              margin: EdgeInsets.only(left: 30.0),
              // child: ButtonTheme(
              //   minWidth: 120,
              child: Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 180,
                    child: RaisedButton(
                      onPressed: () {
                        calculate();
                        print('rai: ' +
                            '$rai,' +
                            'ngaan: ' +
                            '$ngaan,' +
                            'wa: ' +
                            '$wa');
                      },
                      color: CollectionColors.darkgreen(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "คำนวณ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0),
                  RaisedButton(
                    onPressed: () {
                      clear();
                    },
                    color: CollectionColors.mediumbrown(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      "ล้าง",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
              //   ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }

  void clear() {
    setState(() {
      num.text = '0';
      rai = 0;
      ngaan = 0;
      wa = 0;
    });
  }

  void calculate() {
    if (unitFrom == 'ไร่') {
      if (unitTo == 'งาน') {
        setState(() {
          amount = int.parse(num.text);
          ngaan = amount * 4;
        });
      }
      if (unitTo == 'ตารางวา') {
        setState(() {
          amount = int.parse(num.text);
          wa = amount * 400;
        });
      }
    }
    if (unitFrom == 'งาน') {
      if (unitTo == 'ไร่') {
        setState(() {
          amount = int.parse(num.text);
          rai = (amount / 4).floor();
          ngaan = amount - (rai * 4);
        });
      }
      if (unitTo == 'ตารางวา') {
        setState(() {
          amount = int.parse(num.text);
          wa = amount * 100;
        });
      }
    }
    if (unitFrom == 'ตารางวา') {
      if (unitTo == 'ไร่') {
        setState(() {
          amount = int.parse(num.text);
          rai = (amount / 400).floor();
          wa = amount - (rai * 400);
          if (wa >= 100) {
            ngaan = (wa / 100).floor();
            wa = wa - (ngaan * 100);
          }
        });
      }
      if (unitTo == 'งาน') {
        setState(() {
          amount = int.parse(num.text);
          ngaan = (amount / 100).floor();
          wa = amount - (ngaan * 100);
        });
      }
    }
  }
}
