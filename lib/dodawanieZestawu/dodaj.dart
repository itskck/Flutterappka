import 'dart:ui';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:blur/blur.dart';

class dodaj extends StatefulWidget {
  dodaj({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _dodaj createState() => _dodaj();
}

class _dodaj extends State<dodaj> {
  
  List<Widget> panelsGrid1;
  List<Widget> panelsGrid2;
  Widget popupWindow(BuildContext context, String component) {
    return AlertDialog(
      title: Text('Choose your $component: '),
      content: ListView(
        children: [
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }

  Widget addButton(String component) {
    return GestureDetector(
        onTap: () {
          print('tapped');
        },
        child: Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(240, 84, 84, 1),
                      Theme.of(context).shadowColor
                    ])),
            child: Stack(fit: StackFit.passthrough, children: <Widget>[
              Blur(
                blur: 0.8,
                blurColor: Colors.transparent,
                colorOpacity: 0,
                child: Text(
                  '$component ' * 150,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Color.fromRGBO(255, 255, 255, 50)),
                ),
              ),
              Icon(
                Icons.add,
                size: 100,
                color: Colors.white,
              ),
            ])));
  }

  Widget emptyBar() {
    return Opacity(
        opacity: 0,
        child: Container(height: 50, width: MediaQuery.of(context).size.width));
  }

  Widget styledTextBar(String content) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Align(
          alignment: Alignment.center,
          child: Text(content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'coolvetica',
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  letterSpacing: 2,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.8
                    ..color = Colors.red))),
    );
  }

  Widget itemFrame(String model, String component, String photoURL) {
    return Container(
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey, Colors.redAccent])),
        child: Stack(fit: StackFit.passthrough, children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Image(
              image: AssetImage(photoURL),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                model,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'coolvetica',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    letterSpacing: 2,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.white),
              ))
        ]));
  }

 

  @override
  Widget build(BuildContext context) {
    panelsGrid1 = [
      addButton('CPU'),
      addButton('PSU'),
      addButton('MTBRD'),
      addButton('DRIVE'),
      addButton('RAM'),
      addButton('CASE'),
    ];
    panelsGrid2 = [addButton('GPU'), addButton('CSTM COOLER')];
   
    //build context gives the layout, when you build widget it will always have this line
    return SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    styledTextBar('↓ Niezbędniki ↓'),
                    ...panelsGrid1,
                    styledTextBar('↓ Dobrze mieć ↓'),
                    ...panelsGrid2,
                  ])));
  }
}
