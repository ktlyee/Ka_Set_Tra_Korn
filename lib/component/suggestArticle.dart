import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


class addProfilePic extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Row(
                            children: <Widget>[
                              Positioned(
                                left: 80.0,
                                right: 60.0,
                                child: IconButton(
                                    icon: Icon(
                                      MaterialIcons.camera_alt,
                                      size: 30.0,
                                    ),
                                    onPressed: () {
                                      // uploadImage(context);
                                    }),
                              )
                            ],
                            
                          ),
                        ),
        ],
      ),
    );
}
}