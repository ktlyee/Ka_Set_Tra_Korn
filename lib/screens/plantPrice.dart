import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';

class PlantPrice extends StatefulWidget {
  @override
  _PlantPriceState createState() => _PlantPriceState();
}

class _PlantPriceState extends State<PlantPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "ราคาพืชสัปดาห์นี้",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
          backgroundColor: CollectionColors.lightgreen(),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('Plants').snapshots(),
            builder: (context, snapshot) {
              return Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: <Widget>[
                      SizedBox(
                        // width: 300,
                        child: Align(
                          // alignment: Alignment.topLeft,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 140),
                                  child: Text("สำหรับสัปดาห์วันที่",
                                      style: TextStyle(
                                          fontFamily: 'Chonburi',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w100),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 140, top: 10),
                                  child: Text("20/7/63 - 26/7/63",
                                      style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w100),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot plant =
                              snapshot.data.documents[index];
                          return ListTile(
                            title: PlantText(plant['name'] +
                                " " +
                                plant['price'] +
                                " " +
                                plant['unit']),
                            // subtitle: PlantText(plant['price'] + " " + plant['unit']),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.black,
                          );
                        },
                      )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 100,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text("* อัปเดตเมื่อ 20/7/63 เวลา 09.48",
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.right)),
                    ],
                  ),
                ),
              );
            }));
  }
}
