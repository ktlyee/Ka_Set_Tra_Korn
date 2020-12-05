import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kasettakorn/model/plant.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:provider/provider.dart';

import 'myPlantDetail_page.dart';

class MyPlantPage extends StatefulWidget {
  MyPlantPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _MyPlantPageState createState() => _MyPlantPageState();
}

class _MyPlantPageState extends State<MyPlantPage> {
  FirebaseUser currentUser;

  @override
  void initState() {
    this.getCurrentUser();
    MyPlantNotifier myPlantNotifier =
        Provider.of<MyPlantNotifier>(context, listen: false);
    getMyPlant(myPlantNotifier);
    // this.getTotal();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  getMyPlant(MyPlantNotifier myPlantNotifier) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Areas')
        .document(widget.uid)
        .collection('Plants')
        .getDocuments();

    List<MyPlant> _myPlantList = [];

    snapshot.documents.forEach((document) {
      MyPlant myPlant = MyPlant.fromMap(document.data);
      _myPlantList.add(myPlant);
    });

    myPlantNotifier.myPlantList = _myPlantList;
  }

  int income = 0;

  // Future getTotal() async {
  //   // int income = 0;
  //   await Firestore.instance
  //       .collection('Areas')
  //       .document(widget.uid)
  //       .collection('Plants')
  //       .snapshots()
  //       .listen((data) =>
  //           data.documents.forEach((doc) => income += (doc["total"])));
  // }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {
      MyPlantNotifier myPlantNotifier =
          Provider.of<MyPlantNotifier>(context, listen: false);
      getMyPlant(myPlantNotifier);
      // getTotal();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    MyPlantNotifier myPlantNotifier = Provider.of<MyPlantNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: CollectionColors.lightgreen(),
          title: Text(
            "พืชที่กำลังปลูก",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                  child: Card(
                    color: CollectionColors.lightgreen(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                        leading: ClipOval(
                            child: SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: Image.network(
                              myPlantNotifier.myPlantList[index].img != null
                                  ? myPlantNotifier.myPlantList[index].img
                                  : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                              fit: BoxFit.fitWidth),
                        )),
                        title: Text(myPlantNotifier.myPlantList[index].name,
                            style: TextStyle(fontFamily: 'Chonburi')),
                        subtitle: Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ประเภท: " +
                                      myPlantNotifier
                                          .myPlantList[index].category,
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ราคาคาดการณ์: " +
                                      myPlantNotifier.myPlantList[index].total
                                          .toString() +
                                      " บาท",
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          myPlantNotifier.currentMyPlant =
                              myPlantNotifier.myPlantList[index];
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return MyPlantDetail();
                            }),
                          );
                        }),
                  ),
                );
              },
              itemCount: myPlantNotifier.myPlantList.length,
            ),
          ),
          onRefresh: _handleRefresh,
        ));
  }
}
