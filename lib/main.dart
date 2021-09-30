import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'dodawanieZestawu/dodaj.dart';
import 'Glowna/Glowna.dart';
import 'Logowanie/Logowanie.dart';
import 'Porownywarka/Porownywarka.dart';
import 'wczytajZestaw/wczytajZestaw.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/doLogowanie/doLogowanie.dart';
import 'Globalne.dart' as globalna;
import 'config/fileOperations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User _firebaseUser=FirebaseAuth.instance.currentUser;
  final file=fileReader();
  List<String> data;
  data=new List<String>();
  if(_firebaseUser==null) {
    file.save("czyZalogowany=false");
    final doLogowanie _anonim = doLogowanie();
    dynamic result = await _anonim.Anonim();
    if (result == null)
      print('Nie jestes w bazie');
    else
      print(result.uid);
  }
  else print(_firebaseUser.uid);
  await file.read().then((String tekst){
    data.add(tekst);
  });
  globalna.czyZalogowany=data[0];
  inicjalizuj(null);
}

void inicjalizuj(Builds builds) {
  return runApp(MaterialApp(
    home: Skladapka(builds: builds),
  ));
}



ThemeData chooseTheme(int which) {
  if (which == 1)
    return ThemeData(
        canvasColor: Color(0xFF212121),
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        shadowColor: Colors.black);
  else if (which == 0)
    return ThemeData(
        canvasColor: Colors.white,
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: Color(0xFFE5E5E5),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.white),
        dividerColor: Colors.white54,
        shadowColor: Colors.grey[200]);
  else
    return ThemeData();
}

class Skladapka extends StatefulWidget {
  // This widget is the root of your application.
  static Connectivity _connectivity = Connectivity();
  static StreamSubscription<ConnectivityResult> connectivitySubscription;
  static ConnectivityResult connectivityResult= ConnectivityResult.none;

  final Builds builds;

  Skladapka({this.builds});

  @override
  _SkladapkaState createState() => _SkladapkaState();
}

class _SkladapkaState extends State<Skladapka> {

  @override
  void initState() {
    super.initState();
    print('ao');
    Skladapka.connectivitySubscription = Skladapka._connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    print('object');

  }

  void _onItemTapped(int index) {
    if(globalna.ktoro==2) Glowna.connectivitySubscription.cancel();
    globalna.ktoro = index;
    inicjalizuj(null);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      Skladapka.connectivityResult = result;
    });
  }

  @override
  dispose() {
    super.dispose();
    Skladapka.connectivitySubscription.cancel();
  }


  ThemeData chosenTheme = new ThemeData();

  Widget viewReturner(int ktoro){
    if(widget.builds!=null) {
      setState(() {
        globalna.ktoro=ktoro;
      });
      return wczytajZestaw(czyWczytuje: true, builds: widget.builds);
    }
      return Views[ktoro];
  }

  List<Widget> Views = [
    dodaj(),
    wczytajZestaw(czyWczytuje: false,builds: null),
    Glowna(title: 'dodawanie'),
    Porownywarka(title: 'dodawanie'),
    Logowanie(),
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
    print(Theme.of(context).primaryColor);

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
                      inicjalizuj(null);
                    },
                  ))
            ]),
          ),
          body: viewReturner(globalna.ktoro),
          bottomNavigationBar: CurvedNavigationBar(
            index: globalna.ktoro,
            color:Color.fromRGBO(240, 84, 84, 1),
            backgroundColor: chosenTheme.canvasColor,
            animationDuration: Duration(milliseconds: 300),
            height: 55,
            items: <Widget>[
              Icon(Icons.add,color: chosenTheme.canvasColor),
              Icon(Icons.edit,color: chosenTheme.canvasColor),
              Icon(Icons.home,color:  chosenTheme.canvasColor),
              Icon(Icons.leaderboard,color:  chosenTheme.canvasColor),
              Icon(Icons.account_circle_rounded,color:  chosenTheme.canvasColor)
            ],

            onTap: _onItemTapped,
          ),
        )

    );
  }
}