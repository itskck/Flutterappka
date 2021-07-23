import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//import 'dart:html';
import 'package:flutter/material.dart';
import 'homepage.dart';
Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
Homepage homepage = new Homepage(); 
String tekst = homepage.printdb();
/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,      
      home: MyStatefulWidget(),
      
      
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 2;  
  
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30,fontFamily: 'Lobster-1.4');
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Dodawanie',
      style: optionStyle,
    ),  
    Text(
      'Index 2: Wczytywanie',
      style: optionStyle,
    ),
   Text(
      "$tekst",
      style: optionStyle,
    ),
    Text(
      'Index 3: Porównywarka',
      style: optionStyle,
    ),
    Text(
      'Index 4:  Logowanie',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(     
      appBar: AppBar(        
        backgroundColor:Color.fromRGBO(102, 7, 8, 100),
        //leading: Icon(Icons.computer),
        title: Text('Składappka',
        style: TextStyle(fontFamily: 'Lobster-1.4',fontWeight: FontWeight.w400,fontSize: 34),),       
      ),
      body: Center(
        
        child: _widgetOptions.elementAt(_selectedIndex),
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
        selectedItemColor: Color.fromRGBO(102, 7, 8,100) ,
        onTap: _onItemTapped,
      ),
    );
  }
}
