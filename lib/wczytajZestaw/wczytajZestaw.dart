import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
class wczytajZestaw extends StatefulWidget {
  wczytajZestaw({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _wczytajZestaw createState() => _wczytajZestaw();
}
class _wczytajZestaw extends State<wczytajZestaw>{
  int _selectedIndex=1;
  void _onItemTapped(int index){
    ktoro=index;
    inicjalizuj();
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Scaffold( //entry point to your app scaffold blank display
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(240, 84, 84, 1),
        //leading: Icon(Icons.computer),
        title: Text('Składappka',
          style: TextStyle(fontFamily: 'Lobster-1.4',fontWeight: FontWeight.w400,fontSize: 34),),
      ),
      body: Center(
        child: Text("wczytanko"),
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