import 'package:flutter/material.dart';
import 'package:kasettakorn/widget/messaging_widget.dart';
import 'package:kasettakorn/component/bottombar.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4D923),
        title: Text(
          "การแจ้งเตือน",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Chonburi',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: MessagingWidget(),
    );
  }
}

