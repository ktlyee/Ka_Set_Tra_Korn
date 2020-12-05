class Article {
  String author;
  String detail;
  String img;
  String title;
  String id;
  String category;

  Article();

  Article.fromMap(Map<String, dynamic> data) {
    author = data['author'];
    detail = data['detail'];
    img = data['img'];
    title = data['title'];
    id = data['id'];
    category = data['category'];
  }
}