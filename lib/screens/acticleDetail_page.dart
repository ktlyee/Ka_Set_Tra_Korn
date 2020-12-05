import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'บทความ',
            style: TextStyle(
                fontFamily: 'Chonburi',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          backgroundColor: CollectionColors.lightgreen(),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[
            Image.network(articleNotifier.currentArticle.img),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Text(articleNotifier.currentArticle.title,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.15,
                  style: TextStyle(
                      fontFamily: 'Chonburi', fontWeight: FontWeight.w600)),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20.0, left: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("โดย " + articleNotifier.currentArticle.author,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Kanit')),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("         " + articleNotifier.currentArticle.detail,
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.0,
                      style: TextStyle(fontFamily: 'Kanit')),
                )),
                Padding(
                padding: EdgeInsets.only(top: 20.0, left: 25.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("อ้างอิง ",
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontFamily: 'Kanit')),
                )),
          ],
        ))));
  }
}
