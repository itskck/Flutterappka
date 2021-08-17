import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'dodawanieZestawu/dodaj.dart';
import 'Glowna/Glowna.dart';
import 'Logowanie/Logowanie.dart';
import 'Porownywarka/Porownywarka.dart';
import 'wczytajZestaw/wczytajZestaw.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/doLogowanie/doLogowanie.dart';
import 'Globalne.dart' as globalna;

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User _firebaseUser=FirebaseAuth.instance.currentUser;
  if(_firebaseUser==null) {
    final doLogowanie _anonim = doLogowanie();
    dynamic result = await _anonim.Anonim();
    if (result == null)
      print('Nie jestes w bazie');
    else
      print(result.uid);
    globalna.czyZalogowany=false;
  }
  else print(_firebaseUser.uid);
  inicjalizuj();
}

void inicjalizuj() {
  return runApp(MaterialApp(
    home: Skladapka(),
  ));
}

void _onItemTapped(int index) {
    globalna.ktoro = index;
    inicjalizuj();
  }

ThemeData chooseTheme(int which) {
  if (which == 1)
    return ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        shadowColor: Colors.black);
  else if (which == 0)
    return ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: const Color(0xFFE5E5E5),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.white),
        dividerColor: Colors.white54,
        shadowColor: Colors.grey[200]);
  else
    return ThemeData();
}

class Skladapka extends StatelessWidget {
  // This widget is the root of your application.
  
  ThemeData chosenTheme = new ThemeData();
  List<Widget> Views = [
    dodaj(title: 'dodawanie'),
    wczytajZestaw(title: 'dodawanie'),
    Glowna(title: 'dodawanie'),
    Porownywarka(title: 'dodawanie'),
    Logowanie(title: 'dodawanie'),
  ];

  @override
  Widget build(BuildContext context) {
    chosenTheme = chooseTheme(globalna.currentTheme);
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
    
    return MaterialApp(
        theme: chosenTheme,
        title: 'Skladapka', 
        home: Scaffold(
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
                if (globalna.currentTheme == 1)
                  globalna.currentTheme = 0;
                else
                  globalna.currentTheme = 1;
                inicjalizuj();              
            },
          ))
        ]),
      ),
      body: Views[globalna.ktoro],      
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
        currentIndex: globalna.ktoro,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(240, 84, 84, 1) ,
        onTap: _onItemTapped,
      ),
    )
        
  );
  }
}
