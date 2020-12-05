import 'package:flutter/material.dart';
import 'package:kasettakorn/styles/colors.dart';

class TitleText extends StatelessWidget {
  String text;
  double size = 20;
  TitleText(String str) {
    text = str;
  }
  TitleText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Chonburi',
      ),
    );
  }
}

class TitleTextInCard extends StatelessWidget {
  String text;
  double size = 16;
  TitleTextInCard(String str) {
    text = str;
  }
  TitleTextInCard.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Chonburi',
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  String text;
  SubTitleText(String str) {
    text = str;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 15,
        fontFamily: 'Kanit',
      ),
    );
  }
}

class BottombarText extends StatelessWidget {
  String text;
  BottombarText(String str) {
    text = str;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontFamily: 'Kanit',
      ),
    );
  }
}

class ButtonTextwithUnderline extends StatelessWidget {
  String text;
  ButtonTextwithUnderline(String str) {
    text = str;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 15,
        decoration: TextDecoration.underline,
        fontFamily: 'Kanit',
      ),
    );
  }
}

class ProfieTitleText extends StatelessWidget {
  String text;
  double size = 23;
  ProfieTitleText(String str) {
    text = str;
  }
  ProfieTitleText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Chonburi',
      ),
      textAlign: TextAlign.left,
    );
  }
}

class CalculateText extends StatelessWidget {
  String text;
  double size = 18;
  CalculateText(String str) {
    text = str;
  }
  CalculateText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Kanit',
      ),
      textAlign: TextAlign.left,
    );
  }
}

class ButtonActiclePageText extends StatelessWidget {
  String text;
  double size = 17;
  ButtonActiclePageText(String str) {
    text = str;
  }
  ButtonActiclePageText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Chonburi',
      ),
      textAlign: TextAlign.left,
    );
  }
}

class ActiclePageText extends StatelessWidget {
  String text;
  double size = 30;
  ActiclePageText(String str) {
    text = str;
  }
  ActiclePageText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: CollectionColors.darkbrown(),
        fontSize: size,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.left,
    );
  }
}
class PlantText extends StatelessWidget {
  String text;
  double size = 15;
  PlantText(String str) {
    text = str;
  }
  PlantText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w200,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class PlantTitleText extends StatelessWidget {
  String text;
  double size = 15;
  PlantTitleText(String str) {
    text = str;
  }
  PlantTitleText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class PlantCenterText extends StatelessWidget {
  String text;
  double size = 15;
  PlantCenterText(String str) {
    text = str;
  }
  PlantCenterText.withSize(String str, double size) {
    text = str;
    this.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: size,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w200,
      ),
      textAlign: TextAlign.center,
    );
  }
}

