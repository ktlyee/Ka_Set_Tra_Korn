import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/model/article.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';
import 'package:kasettakorn/screens/acticleDetail_page.dart';
import 'package:kasettakorn/service/article_service.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String activeTag = 'ทั่วไป';

  @override
  void initState() {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    // getArticles(articleNotifier);
    getArticlesGeneral(articleNotifier);

    super.initState();

    setState(() {
      activeTag = 'ทั่วไป';
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4D923),
        title: Text(
          "บทความทั้งหมด",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Chonburi',
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: TitleText('หมวดหมู่'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            _buildButton('ทั่วไป'),
                            SizedBox(
                              width: 10,
                            ),
                            _buildButton('ผัก'),
                            SizedBox(
                              width: 10,
                            ),
                            _buildButton('ผลไม้'),
                            SizedBox(
                              width: 10,
                            ),
                            _buildButton('ดอกไม้')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
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
                                    leading: SizedBox(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  articleNotifier
                                                              .articleList[
                                                                  index]
                                                              .img !=
                                                          null
                                                      ? articleNotifier
                                                          .articleList[index]
                                                          .img
                                                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                                ),
                                                fit: BoxFit.cover),
                                          )),
                                    ),
                                    title: TitleTextInCard(
                                      articleNotifier.articleList[index].title,
                                    ),
                                    subtitle: SubTitleText(
                                      articleNotifier.articleList[index].author,
                                    ),
                                  ),
                                  ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                        child: ButtonTextwithUnderline(
                                            'คลิกเพื่ออ่านต่อ'),
                                        // color: CollectionColors.lightbrown(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          articleNotifier.currentArticle =
                                              articleNotifier
                                                  .articleList[index];
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return ArticleDetailPage();
                                          }));
                                        },
                                      ),
                                    ],
                                  ),
                                ]))));
              },
              itemCount: articleNotifier.articleList.length,
            ))
          ],
        ),
      ),
    );
  }

  _buildButton(category) {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);

    Color color = category == activeTag
        ? CollectionColors.darkgreen()
        : CollectionColors.mediumbrown();

    if (category == 'ทั่วไป') {
      return RaisedButton(
          color: color,
          child: ButtonActiclePageText('$category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            getArticlesGeneral(articleNotifier);
            setState(() {
              activeTag = category;
            });
          });
    }
    if (category == 'ผัก') {
      return RaisedButton(
          color: color,
          child: ButtonActiclePageText('$category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            getArticlesPlant(articleNotifier);
            setState(() {
              activeTag = category;
            });
          });
    }
    if (category == 'ผลไม้') {
      return RaisedButton(
          color: color,
          child: ButtonActiclePageText('$category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            getArticlesFruit(articleNotifier);
            setState(() {
              activeTag = category;
            });
          });
    }

    if (category == 'ดอกไม้') {
      return RaisedButton(
          color: color,
          child: ButtonActiclePageText('$category'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            getArticlesFlower(articleNotifier);
            setState(() {
              activeTag = category;
            });
          });
    }
  }
}
