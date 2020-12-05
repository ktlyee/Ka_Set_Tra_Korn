import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:kasettakorn/model/article.dart';

class ArticleNotifier with ChangeNotifier {
  List<Article> _articleList = [];
  Article _currentArticle;

  UnmodifiableListView<Article> get articleList => UnmodifiableListView(_articleList);

  Article get currentArticle => _currentArticle;

  set articleList(List<Article> articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  set currentArticle(Article article) {
    _currentArticle = article;
    notifyListeners();
  }
}