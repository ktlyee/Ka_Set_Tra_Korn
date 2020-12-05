class Plant {
  String id;
  String name;
  String period;
  String soil;
  String season;
  String month;
  String weather;
  String method;
  String category;
  String img;

  Plant();

  Plant.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    period = data['period'];
    soil = data['soil'];
    season = data['season'];
    month = data['month'];
    weather = data['weather'];
    method = data['method'];
    category = data['category'];
    img = data['img'];
  }
}

class MyPlant {
  String id;
  String name;
  String period;
  String soil;
  String season;
  String month;
  String weather;
  String method;
  String category;
  String rai;
  String ngaan;
  String wa;
  String img;
  int total;

  MyPlant();

  MyPlant.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    period = data['period'];
    soil = data['soil'];
    season = data['season'];
    month = data['month'];
    weather = data['weather'];
    method = data['method'];
    category = data['category'];
    rai = data['rai'];
    ngaan = data['ngaan'];
    wa = data['wa'];
    img = data['img'];
    total = data['total'];
  }
}
