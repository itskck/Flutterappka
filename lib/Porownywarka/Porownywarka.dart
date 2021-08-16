import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Porownywarka extends StatefulWidget {
  Porownywarka({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Porownywarka createState() => _Porownywarka();
}
class _Porownywarka extends State<Porownywarka>{
  int _selectedIndex=3;
  void _onItemTapped(int index){
    globalna.ktoro=index;
    inicjalizuj();
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    Icon moonIcon;
    if (globalna.currentTheme == 0)
      moonIcon = Icon(
        Icons.brightness_2_outlined,
        color: Colors.white,
      );
    else
      moonIcon = Icon(
        Icons.brightness_2,
        color: Colors.white,
      );
    //build context gives the layout, when you build widget it will always have this line
    return Scaffold(
      //entry point to your app scaffold blank display
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 84, 84, 1),
        //leading: Icon(Icons.computer),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
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
          Container(
              child: IconButton(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            icon: moonIcon,
            onPressed: () {
              setState(() {
                if (globalna.currentTheme == 1)
                  globalna.currentTheme = 0;
                else
                  globalna.currentTheme = 1;
                inicjalizuj();
              });
            },
          ))
        ]),
      ),
      body: Center(
        child: Text("Porownywarka"),
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
              icon: Icon(Icons.leaderboard),
              label: 'Porównywarka'),
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Zaloguj')
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(240, 84, 84, 1) ,
        onTap: _onItemTapped,
      ),
    );
  }
}