import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';
import 'package:kasettakorn/service/article_service.dart';
import 'package:provider/provider.dart';

import 'package:kasettakorn/screens/acticleDetail_page.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:kasettakorn/styles/text.dart';
import 'package:kasettakorn/screens/article_page.dart';
import 'package:kasettakorn/screens/plantPrice.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseUser currentUser;

  List<Widget> _pages = [];

  int page = 0;

  final _controller = PageController();

  @override
  void initState() {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    getArticlesGeneral(articleNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            backgroundColor: Color(0xFFC4D923),
            flexibleSpace: FlexibleSpaceBar(
              title: StreamBuilder(
                  stream: Firestore.instance
                      .collection('Users')
                      .document(widget.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("");
                    }
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (snapshot.data['img'] != null)
                                        ? NetworkImage(snapshot.data['img'])
                                        : NetworkImage(
                                            'https://i.pinimg.com/originals/2e/2f/ac/2e2fac9d4a392456e511345021592dd2.jpg',
                                          ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // child: Padding(
                                      // padding: EdgeInsets.only(right: 70),
                                      child: ProfieTitleText('สวัสดี'),
                                      // ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: ProfieTitleText(
                                          snapshot.data['Username']),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            // child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: TitleText('บทความแนะนำ'),
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
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
                                      articleNotifier.articleList
                                                  .elementAt(1)
                                                  .img !=
                                              null
                                          ? articleNotifier.articleList
                                              .elementAt(1)
                                              .img
                                          : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          title: TitleTextInCard(
                            articleNotifier.articleList.elementAt(1).title,
                          ),
                          subtitle: SubTitleText(
                            articleNotifier.articleList.elementAt(1).author,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: CollectionColors.lightbrown(),
                              child: SubTitleText("คลิกเพื่ออ่านต่อ"),
                              onPressed: () {
                                articleNotifier.currentArticle =
                                    articleNotifier.articleList.elementAt(1);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ArticleDetailPage();
                                }));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: CollectionColors.darkgreen(),
                      child: SubTitleText("ดูบทความทั้งหมด"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ArticlePage()));
                      },
                    )
                  ],
                ),
                SizedBox(
                  width: 300,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TitleText('ราคาพืชสัปดาห์นี้'),
                          Text("* วันที่ 20/7/63 - 26/7/63 *",
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.left)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Table(
                  border: TableBorder.symmetric(
                      inside:
                          BorderSide(width: 1, color: CollectionColors.gray())),
                  columnWidths: {
                    0: FractionColumnWidth(.5),
                    1: FractionColumnWidth(.3),
                    2: FractionColumnWidth(.2)
                  },
                  children: [
                    TableRow(children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 10, bottom: 10, right: 20),
                        child: PlantTitleText('พืช'),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: PlantTitleText('ราคา'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: PlantTitleText('หน่วย'),
                      ),
                    ]),
                    TableRow(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 10, top: 5),
                          child: PlantText("ถั่วฝักยาว"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("35 - 40"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("บาท/กก."),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 10, top: 5),
                          child: PlantText("ข้าวโพดหวาน"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("10"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("บาท/กก."),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 10, top: 5),
                          child: PlantText("คะน้า"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("20 - 25"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 5),
                          child: PlantCenterText("บาท/กก."),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: CollectionColors.darkgreen(),
                      child: SubTitleText("ดูราคาพืชทั้งหมด"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => PlantPrice()));
                      },
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // ImageSliderDemo(),
                      Text('Advertising Area')
                    ],
                  ),
                  height: 50,
                  width: 450,
                  color: CollectionColors.gray(),
                  // child: ImageSliderDemo(),
                )
              ],
            ),
          ),
        ));
  }
}
