import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:kasettakorn/styles/colors.dart';

class articleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
          color: CollectionColors.lightgreen(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: TitleTextInCard('The Enchanted Nightingale'),
                subtitle: SubTitleText(
                    'Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: SubTitleText('คลิกเพื่ออ่านต่อ'),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //   body: SingleChildScrollView(
      // child: Container(
      //   child: Center(
      //     child: Column(
      //       children: <Widget>[
      //         // Card(
      //           Row(
      //             children: <Widget>[
      //               // Column 1
      //               Expanded(
      //                 flex: 7,
      //                 child: Padding(
      //                   padding: EdgeInsets.all(20.0),
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       Text("Column 1"),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               // Column 2
      //               // The Place where I am Stuck//
      //               Expanded(
      //                 flex: 3,
      //                 child: Container(
      //                   color: Colors.blue,
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.max,
      //                     children: <Widget>[
      //                       Text("Column 2"),
      //                     ],
      //                   ),
      //                 ),
      //               )
      //               // COlumn 2 End
      //             ],
      //           ),
      //         // )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
