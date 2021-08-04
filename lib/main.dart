import 'package:flutter/material.dart';
import 'dodawanieZestawu/dodaj.dart';
import 'Glowna/Glowna.dart';
import 'Logowanie/Logowanie.dart';
import 'Porownywarka/Porownywarka.dart';
import 'wczytajZestaw/wczytajZestaw.dart';
import 'package:flutter/material.dart';

int ktoro=2;
void main() {
  return runApp(MaterialApp(
    home: Skladapka(),
  ));
}

class Skladapka extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(ktoro==0) return MaterialApp(
      title: 'Skladapka',
      home: dodaj(title: 'dodawanie'),
    );
    if(ktoro==1) return MaterialApp(
      title: 'Skladapka',
      home: wczytajZestaw(title: 'dodawanie'),
    );
    if(ktoro==2) return MaterialApp(
      title: 'Skladapka',
      home: Glowna(title: 'dodawanie'),
    );
    if(ktoro==3) return MaterialApp(
      title: 'Skladapka',
      home: Porownywarka(title: 'dodawanie'),
    );
    if(ktoro==4) return MaterialApp(
      title: 'Skladapka',
      home: Logowanie(title: 'dodawanie'),
    );
  }
}
