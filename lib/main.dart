import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  return runApp(Container(
    child: Skladapka(builds: builds),
  ));
}



ThemeData appTheme(){
  return ThemeData(        
        canvasColor: Color.fromRGBO(32, 33, 36,1),
        primarySwatch: Colors.grey,
        primaryColor: Color.fromRGBO(37, 38, 41,1),
        brightness: Brightness.light,
        backgroundColor: Color(0xFFE5E5E5),
        accentColor: Colors.black,
        accentIconTheme: IconThemeData(color: Colors.white),
        dividerColor: Colors.white54,
        shadowColor: Colors.grey[200]);
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        title: 'Skladapka',
        home: Scaffold(
          backgroundColor: appTheme().primaryColor,
          //entry point to your app scaffold blank display
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 50,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: appTheme().primaryColor,
              statusBarIconBrightness: Brightness.light
            ),
            backgroundColor: appTheme().primaryColor,
            //backgroundColor: appTheme().canvasColor,
            
            //leading: Icon(Icons.computer),
            title:
            GradientText(
              'składappka',
              colors: [
                Colors.lightBlue[300],
                Color.fromRGBO(178, 150, 255,1)
              ],
              style: TextStyle(
                  
                  fontFamily: GoogleFonts.workSans().fontFamily,                  
                  fontWeight: FontWeight.normal,
                  fontSize: 34,
                  letterSpacing: 2,
                  
                  ),
            ),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (details){
              if(details.primaryVelocity>0){
                //w prawo
                globalna.ktoro-=1;
                if(globalna.ktoro<0)globalna.ktoro=0;
                setState(() {
                  
                });
              }
              if(details.primaryVelocity<0){
                //w lewo
                globalna.ktoro+=1;
                if(globalna.ktoro>4)globalna.ktoro=4;
                setState(() {
                  
                });
              }
            },
            child: Container(
              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(45, 45, 45,1),
                    Color.fromRGBO(59, 55, 68,1)
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
              child: viewReturner(globalna.ktoro)
              ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: globalna.ktoro,
            color:Colors.lightBlue[300].withOpacity(0.8),
            backgroundColor: Color.fromRGBO(59, 55, 68,1),            
            animationDuration: Duration(milliseconds: 300),
            
            height: 50,
            items: <Widget>[
              Icon(Icons.add,color: Colors.white),
              Icon(Icons.edit,color: Colors.white),
              Icon(Icons.home,color:  Colors.white),
              Icon(Icons.leaderboard,color:  Colors.white),
              Icon(Icons.account_circle_rounded,color:  Colors.white)
            ],

            onTap: _onItemTapped,
          ),
        )

    );
  }
}