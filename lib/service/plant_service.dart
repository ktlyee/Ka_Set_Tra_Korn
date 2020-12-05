import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasettakorn/model/plant.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';

getPlantLoam(PlantNotifier plantNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('ดินร่วน').getDocuments();

  List<Plant> _plantList = [];

  snapshot.documents.forEach((document) {
    Plant plant = Plant.fromMap(document.data);
    _plantList.add(plant);
  });

  plantNotifier.plantList = _plantList;
}

getPlantClay(PlantNotifier plantNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('ดินเหนียว').getDocuments();

  List<Plant> _plantList = [];

  snapshot.documents.forEach((document) {
    Plant plant = Plant.fromMap(document.data);
    _plantList.add(plant);
  });

  plantNotifier.plantList = _plantList;
}

getPlantSandy(PlantNotifier plantNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('ดินทราย').getDocuments();

  List<Plant> _plantList = [];

  snapshot.documents.forEach((document) {
    Plant plant = Plant.fromMap(document.data);
    _plantList.add(plant);
  });

  plantNotifier.plantList = _plantList;
}
