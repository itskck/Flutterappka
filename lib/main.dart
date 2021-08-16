import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'dodawanieZestawu/dodaj.dart';
import 'Glowna/Glowna.dart';
import 'Logowanie/Logowanie.dart';
import 'Porownywarka/Porownywarka.dart';
import 'wczytajZestaw/wczytajZestaw.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Globalne.dart' as globalna;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final doLogowanie _anonim=doLogowanie();
  await _anonim.Anonim();
  inicjalizuj();
}

void inicjalizuj(){
  return runApp(MaterialApp(
    home: Skladapka(),
  ));
}



ThemeData chooseTheme(int which){
    if(which == 1) return ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    shadowColor: Colors.black
  );
  else if(which == 0)return ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    shadowColor:  Colors.grey[200]
  );
  else return ThemeData();


}

class Skladapka extends StatelessWidget {
  // This widget is the root of your application.  
  ThemeData chosenTheme = new ThemeData();
  
  @override
  Widget build(BuildContext context) {
    chosenTheme = chooseTheme(globalna.currentTheme);
    if(globalna.ktoro==0) return MaterialApp(
      theme: chosenTheme,
      title: 'Skladapka',
      home: dodaj(title: 'dodawanie'),
    );
    if(globalna.ktoro==1) return MaterialApp(
      theme: chosenTheme,
      title: 'Skladapka',
      home: wczytajZestaw(title: 'dodawanie'),
    );
    if(globalna.ktoro==2) return MaterialApp(
      theme: chosenTheme,
      title: 'Skladapka',
      home: Glowna(title: 'dodawanie'),
    );
    if(globalna.ktoro==3) return MaterialApp(
      theme: chosenTheme,
      title: 'Skladapka',
      home: Porownywarka(title: 'dodawanie'),
    );
    if(globalna.ktoro==4) return MaterialApp(
      theme: chosenTheme,
      title: 'Skladapka',
      home: Logowanie(title: 'dodawanie'),
    );
  }
}
