import 'dart:ui';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:blur/blur.dart';
import 'package:animations/animations.dart';
import 'dialogWidget.dart';
class dodaj extends StatefulWidget {
  static var chosenCPU,chosenPSU,chosenMTB,chosenDrive,chosenRAM,chosenCase,chosenGPU,chosenCooler;
  dodaj({Key key, this.title,chosenCPU}) : super(key: key);
  
  final String title;
  
  @override
  _dodaj createState() => _dodaj();
}

class _dodaj extends State<dodaj> {

  @override
  initState(){
    super.initState();    
  }
  
  dialogWidget dialogwidget = new dialogWidget();
  List<Widget> panelsGrid1;
  List<Widget> panelsGrid2;
 

  Widget componentsList(String component){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }

  Widget addButton(String component) {
    return GestureDetector(
        onTap: () {
          dialogwidget.showPopup(context, component);          
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
    if(dodaj.chosenCPU !=null) setState(() {
          panelsGrid1[0]=itemFrame(dodaj.chosenCPU.toString(), 'CPU', '/assets/placeholder.png');
        });
   
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
