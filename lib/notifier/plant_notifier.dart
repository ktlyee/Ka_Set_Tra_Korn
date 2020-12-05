import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:kasettakorn/model/plant.dart';

class PlantNotifier with ChangeNotifier {
  List<Plant> _plantList = [];
  Plant _currentPlant;

  UnmodifiableListView<Plant> get plantList => UnmodifiableListView(_plantList);

  Plant get currentPlant => _currentPlant;

  set plantList(List<Plant> plantList) {
    _plantList = plantList;
    notifyListeners();
  }

  set currentPlant(Plant plant) {
    _currentPlant = plant;
    notifyListeners();
  }
}

class MyPlantNotifier with ChangeNotifier {
  List<MyPlant> _myPlantList = [];
  MyPlant _currentMyPlant;

  UnmodifiableListView<MyPlant> get myPlantList =>
      UnmodifiableListView(_myPlantList);

  MyPlant get currentMyPlant => _currentMyPlant;

  set myPlantList(List<MyPlant> myPlantList) {
    _myPlantList = myPlantList;
    notifyListeners();
  }

  set currentMyPlant(MyPlant myPlant) {
    _currentMyPlant = myPlant;
    notifyListeners();
  }

  deleteMyPlant(MyPlant myPlant) {
    _myPlantList.removeWhere((_myPlant) => _myPlant.id == myPlant.id);
    notifyListeners();
  }
}
