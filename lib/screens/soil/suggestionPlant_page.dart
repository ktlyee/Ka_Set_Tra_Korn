import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kasettakorn/notifier/plant_notifier.dart';
import 'package:kasettakorn/screens/soil/plantDetail_page.dart';
import 'package:kasettakorn/service/plant_service.dart';
import 'package:kasettakorn/styles/colors.dart';
import 'package:provider/provider.dart';

class SuggestionPlantPage extends StatefulWidget {
  SuggestionPlantPage({Key key, this.soilType}) : super(key: key);
  String soilType;

  @override
  _SuggestionPlantPageState createState() => _SuggestionPlantPageState();
}

class _SuggestionPlantPageState extends State<SuggestionPlantPage> {
  @override
  void initState() {
    PlantNotifier plantNotifier =
        Provider.of<PlantNotifier>(context, listen: false);
    switch (widget.soilType) {
      case 'ดินเหนียว':
        getPlantClay(plantNotifier);
        break;
      case 'ดินร่วน':
        getPlantLoam(plantNotifier);
        break;
      case 'ดินทราย':
        getPlantSandy(plantNotifier);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CollectionColors.lightgreen(),
          title: Text(
            "พืชแนะนำ",
            style: TextStyle(fontFamily: 'Chonburi', color: Colors.black),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Column(children: <Widget>[
              Expanded(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                      child: Card(
                          color: CollectionColors.lightgreen(),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                              leading: ClipOval(
                                  child: SizedBox(
                                height: 60.0,
                                width: 60.0,
                                child: Image.network(
                                    plantNotifier.plantList[index].img != null
                                        ? plantNotifier.plantList[index].img
                                        : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                    fit: BoxFit.fitWidth),
                              )),
                              title: Text(plantNotifier.plantList[index].name,
                                  style: TextStyle(fontFamily: 'Chonburi')),
                              subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ประเภท: " +
                                      plantNotifier.plantList[index].category,
                                  style: TextStyle(fontFamily: 'Kanit'),
                                ),
                              ),
                              onTap: () {
                                plantNotifier.currentPlant =
                                    plantNotifier.plantList[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PlantDetail();
                                }));
                              })));
                },
                itemCount: plantNotifier.plantList.length,
              ))
            ])));
  }
}
