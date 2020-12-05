import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:kasettakorn/widget/messaging_widget.dart';

import '../screens/home_page.dart';
import '../screens/article_page.dart';
import '../screens/notification_page.dart';
import '../screens/profile_page.dart';
import 'package:kasettakorn/screens/suggestion_page.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key key, this.uid}) : super(key: key);
  final String uid;

  static const routeName = '/';

  @override
  _BottomBarState createState() {
    return _BottomBarState();
  }
}

class _BottomBarState extends State<BottomBar> {
  FirebaseUser currentUser;

  var tabs;
  int _selectedIndex = 0;

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
    tabs = [
      Container(child: MyHomePage(uid: widget.uid)),
      Container(child: SuggestionPage(uid: widget.uid)),
      Container(child: ArticlePage()),
      Container(child: NotificationPage()),
      Container(child: ProfilePage(uid: widget.uid)),
      // Container(child: PlantDetail()),
      // Container(child: ArticleDetailPage()),
      // Container(child: CalculatorPage()),
    ];
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

//  bool newNotification = false;

  // List<Widget> _pageWidget = <Widget>[
  //   MyHomePage(),
  //   SuggestionPage(uid: currentUser.uid),
  //   ArticlePage(),
  //   NotificationPage(),
  //   ProfilePage(),
  // ];
//   List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(MaterialIcons.home),
//       title: Text('หน้าหลัก'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(MaterialIcons.spa),
//       title: Text('พืชแนะนำ'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(MaterialIcons.description),
//       title: Text('บทความ'),
//     ),
//     BottomNavigationBarItem(
//       icon:
// //          NotificationWidget(
// //            icon: Icon(Icons.notifications), newNotification: false,
// //          ),
// //        ],
// //      ),
// //      StreamBuilder(
// //        builder: (_, snapshot) => NotificationWidget(
// //          icon: Icon(Icons.notifications), index: snapshot.data,
// //        ),
// //      ),
//           Icon(Icons.notifications),
//       title: Text('แจ้งเตือน'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(MaterialIcons.account_circle),
//       title: Text('โปรไฟล์'),
//     ),
//   ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
//      if(index == 1){
//        newNotification = false;
//        NotificationWidget(newNotification: false);
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pageWidget.elementAt(_selectedIndex),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MaterialIcons.home),
              title: BottombarText('หน้าหลัก'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialIcons.spa),
              title: BottombarText('การเกษตร'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialIcons.description),
              title: BottombarText('บทความ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: BottombarText('การแจ้งเตือน'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialIcons.account_circle),
              title: BottombarText('โปรไฟล์'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: CollectionColors.mediumbrown(),
          // items: _menuBar,
          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xFFF2F2f2),
          selectedItemColor: Color(0xFF333333),
          onTap: _onItemTapped),
    );
  }
}
