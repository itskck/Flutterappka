import 'dart:ui';

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
  int _selectedIndex = 0;  
  List<Widget> panelsGrid;

  Widget popupWindow(BuildContext context, String component){
    return AlertDialog(
      title: Text('Choose your $component: '),
      content: ListView(
        children: [Text('data'),Text('data'),Text('data'),Text('data'),Text('data'),Text('data'),],
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
            width: 500,
            height: 500,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromRGBO(240, 84, 84, 1), Colors.grey])),
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

  Widget itemFrame(String model, String component, String photoURL) {
    return Container(
        margin: EdgeInsets.all(15),
        width: 500,
        height: 500,
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

  void _onItemTapped(int index) {
    ktoro = index;
    inicjalizuj();
  }

  @override
  Widget build(BuildContext context) {
    //build context gives the layout, when you build widget it will always have this line
    return Scaffold(
      //entry point to your app scaffold blank display
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 84, 84, 1),
        //leading: Icon(Icons.computer),
        title: Text(
          'składappka',
          style: TextStyle(
              fontFamily: 'coolvetica',
              fontWeight: FontWeight.normal,
              fontSize: 34,
              letterSpacing: 2,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white),
        ),
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          crossAxisCount: 2,
          children: [
            addButton('CPU'),
             addButton('PSU'),
              addButton('MTBRD'),
               addButton('DRIVE'),
                addButton('RAM'),
                itemFrame('Generic case 5000', 'CASE', 'assets/placeholder.png')

           
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj zestaw',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: 'Wczytaj zestaw',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Strona główna',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: 'Porównywarka'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Zaloguj')
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(240, 84, 84, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
