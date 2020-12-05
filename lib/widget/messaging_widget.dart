import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:kasettakorn/model/message.dart';
import 'package:kasettakorn/model/plant.dart';
import 'package:kasettakorn/screens/soil/myPlant_page.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
//  int _bottomNavBarSelectedIndex = 0;
//  bool _newNotification = false;

  FirebaseUser currentUser;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<MessageDB> messages = [];
  static int i = 0;

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    _getToken();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var platform = new InitializationSettings(android, null);
    flutterLocalNotificationsPlugin.initialize(platform);

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      if (i % 2 == 0) {
        print("onMessage: $message");
        showNotification(message);
        final notification = message['data'];
        setState(() {
//              _newNotification = true;
//              NotificationWidget(newNotification: true);
          messages.add(MessageDB(
              title: notification['title'], body: notification['body']));
        });
      }
      ;
      i++;
    }, onResume: (Map<String, dynamic> message) async {
      if (i % 2 == 0) {
        print("onResume: $message");
        final notification = message['data'];
        handleRouting(notification);
        setState(() {
          messages.add(MessageDB(
              title: notification['title'], body: notification['body']));
        });
      }
      ;
      i++;
    });
  }

  void showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
      '1234',
      'channelName',
      'channelDescription',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var platform = new NotificationDetails(android, null);
    await flutterLocalNotificationsPlugin.show(
        Random().nextInt(50),
        message['notification']['title'],
        message['notification']['body'],
        platform);
  }

  void handleRouting(dynamic notification) {
    switch (notification['title']) {
      case 'คุณได้เริ่มปลูกพืชชนิดใหม่':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                MyPlantPage(uid: currentUser.uid)));
        break;
    }
  }

//  void _onItemTapped(int index) {
//    setState(() {
//      _bottomNavBarSelectedIndex = index;
//      if(index == 1){
//        _newNotification = false;
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      bottomNavigationBar: BottomNavigationBar(
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(MaterialIcons.home),
//              title: Text("Home"),
//          ),
//          BottomNavigationBarItem(
//            icon: _newNotification ? Stack(
//                children: <Widget>[
//                  Icon(MaterialIcons.notifications),
//                  Positioned(
//                      right: 0,
//                      child: Container(
//                        padding: EdgeInsets.all(1),
//                        decoration: BoxDecoration(
//                          color: Colors.red,
//                          borderRadius: BorderRadius.circular(15),
//                        ),
//                        constraints: BoxConstraints(
//                          minWidth: 13,
//                          minHeight: 13,
//                        ),
//                        child: Text(
//                          'N',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 8,
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                      )
//                  )
//                ]
//            ) : Icon(Icons.notifications),
//            title: Text('Notifications'),
//          ),
//        ],
//        currentIndex: _bottomNavBarSelectedIndex,
//        onTap: _onItemTapped,
//      ),
      body: ListView(
        children: messages.map(buildMessage).toList(),
      ),
    );
  }

  Widget buildMessage(MessageDB message) {
    return ListTile(
      title: Text(
        message.title,
        style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.w400),
      ),
      subtitle: Text(message.body, style: TextStyle(fontFamily: 'Kanit')),
      onTap: () {
        switch (message.title) {
          case 'คุณได้เริ่มปลูกพืชชนิดใหม่':
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyPlantPage(uid: currentUser.uid)));
            break;
        }
      },
    );
  }
}

//class NotificationWidget extends StatelessWidget {
//  NotificationWidget(
//      {this.icon, this.newNotification = false});
//  final Widget icon;
//  final bool newNotification;
//  int index;
//
//  @override
//  Widget build(BuildContext context) {
//    return new Stack(
//      children: <Widget>[
//        icon,
//        if(index == 1 || newNotification) badge(newNotification)
//      ],
//    );
//  }
//
//  Widget badge(bool noti) => Positioned(
//      right: 0,
//      child: Container(
//        padding: EdgeInsets.all(1),
//        decoration: BoxDecoration(
//          color: Colors.red,
//          borderRadius: BorderRadius.circular(15),
//        ),
//        constraints: BoxConstraints(
//          minWidth: 13,
//          minHeight: 13,
//        ),
//        child: Text(
//          'N',
//          style: TextStyle(
//            color: Colors.white,
//            fontSize: 8,
//          ),
//          textAlign: TextAlign.center,
//        ),
//      )
//  );
//}
