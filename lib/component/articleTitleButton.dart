import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';

class articleTitleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // color: Color(0xFFF2B950),
                    // color: Color(0xFFD99441),
                    color: CollectionColors.lightbrown(),
                    highlightColor: CollectionColors.darkgreen(),
                    onPressed: () {},
                    child: SubTitleText("หัวข้อ"),
                  ),
                ],
              ),
            )));
  }
}
