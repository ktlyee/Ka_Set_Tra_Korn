import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasettakorn/model/article.dart';
import 'package:kasettakorn/notifier/article_notifier.dart';

getArticles(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('Articles').getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });

  articleNotifier.articleList = _articleList;
}

getArticlesGeneral(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Articles')
      .document('zxi9ppqNUSWcxHZsEuc1')
      .collection('ทั่วไป')
      .getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });

  articleNotifier.articleList = _articleList;
}

getArticlesPlant(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Articles')
      .document('zxi9ppqNUSWcxHZsEuc1')
      .collection('ผัก')
      .getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });

  articleNotifier.articleList = _articleList;
}

getArticlesFruit(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Articles')
      .document('zxi9ppqNUSWcxHZsEuc1')
      .collection('ผลไม้')
      .getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });

  articleNotifier.articleList = _articleList;
}

getArticlesFlower(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Articles')
      .document('zxi9ppqNUSWcxHZsEuc1')
      .collection('ดอกไม้')
      .getDocuments();

  List<Article> _articleList = [];

  snapshot.documents.forEach((document) {
    Article article = Article.fromMap(document.data);
    _articleList.add(article);
  });

  articleNotifier.articleList = _articleList;
}
