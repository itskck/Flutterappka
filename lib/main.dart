import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skladappka/Firebase/DoLogowania/DoLogowania.dart';
import 'package:skladappka/OcenKomponenty/KtoraStrona.dart';
import 'package:skladappka/Poradnik/Poradnik.dart';
import 'dodawanieZestawu/Dodaj.dart';
import 'Logowanie/Logowanie.dart';
import 'Porownywarka/Porownywarka.dart';
import 'wczytajZestaw/WczytajZestaw.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/DoLogowania/DoLogowania.dart';
import 'Cache.dart' as cache;
import 'config/OperacjePliki.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skladappka/OcenKomponenty/OcenKomponenty.dart';
import 'package:flutter/services.dart';
import 'package:skladappka/OcenKomponenty/Przejscie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) =>
      Center(child: CircularProgressIndicator());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User _firebaseUser = FirebaseAuth.instance.currentUser;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final file = fileReader();
  List<String> data;
  String pom = "";
  int licznik = 0;
  bool sprawdzacz = false;
  data = new List<String>();

  if (_firebaseUser == null) {
    file.save("czyZalogowany=false", 'loginConfig');
    final doLogowanie _anonim = doLogowanie();
    dynamic result = await _anonim.Anonim();
  } else
    print(_firebaseUser.uid);
  if (await file.exists('tutorialConfig') == false) {
    print("her");
    file.save('tutorial=true', 'tutorialConfig');
  }
  await file.read('loginConfig').then((String tekst) {
    data.add(tekst);
  });
  await file.read('tutorialConfig').then((String tekst) {
    data.add(tekst);
  });

  cache.czyZalogowany = data[0];
  print(data[1]);
  if (data[1] == "tutorial=false") sprawdzacz = true;
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      title: 'Skladapka',
      home: Glowna(title: data[1])));
}

void inicjalizuj(Builds builds) {
  return runApp(Container(
    child: Skladapka(builds: builds),
  ));
}

Future<int> getAvatarNumber() async {
  var chosenAvatar;
  await FirebaseFirestore.instance
      .collection("users")
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((QuerySnapshot result) => {
            result.docs.forEach((element) {
              if (element['aid'] != null)
                chosenAvatar = element['aid'];
              else
                chosenAvatar = 0;
            })
          });

  return chosenAvatar;
}

ThemeData appTheme() {
  return ThemeData(
      canvasColor: Color.fromRGBO(32, 33, 36, 1),
      primarySwatch: Colors.grey,
      primaryColor: Color.fromRGBO(37, 38, 41, 1),
      brightness: Brightness.light,
      backgroundColor: Color(0xFFE5E5E5),
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
      shadowColor: Colors.grey[200]);
}

class Skladapka extends StatefulWidget {
  // This widget is the root of your application.
  static StreamSubscription<ConnectivityResult> connectivitySubscription;
  static Connectivity connectivity = Connectivity();
  static ConnectivityResult connectivityResult = ConnectivityResult.none;
  final Builds builds;
  static String test = "estuje";

  Skladapka({this.builds});

  @override
  _SkladapkaState createState() => _SkladapkaState();
}

class _SkladapkaState extends State<Skladapka> {
  final doLogowanie _anonim = doLogowanie();
  void _onItemTapped(int index) {
    cache.ktoro = index;
    inicjalizuj(null);
  }

  @override
  void initState() {
    super.initState();
    Skladapka.connectivitySubscription = Skladapka
        .connectivity.onConnectivityChanged
        .listen(_updateConnectionStatus); //ustawienie subskrybcji
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if(result==ConnectivityResult.none){
      setState(() {
        cache.ktoro=2;
        Skladapka.connectivityResult = result; //zmiana rezultatu po????czenia
      });
    }
    else
    setState(() {
      Skladapka.connectivityResult = result; //zmiana rezultatu po????czenia
    });
  }

  Widget viewReturner(int ktoro) {
    if (widget.builds != null) {
      print("tak, tak");
      setState(() {
        cache.ktoro = ktoro;
      });
      if (ktoro == 1)
        return wczytajZestaw(czyWczytuje: true, builds: widget.builds);
      else
        return whichSite(czyWczytuje: true, builds: widget.builds);
    } else
      return Views[ktoro];
  }

  List<Widget> Views = [
    rateComponents(),
    wczytajZestaw(czyWczytuje: false, builds: null),
    dodaj(),
    Porownywarka(),
    Logowanie(),
  ];
  final List<Image> avatarList = [
    Image.asset('assets/avatars/1.png'),
    Image.asset('assets/avatars/2.png'),
    Image.asset('assets/avatars/3.png'),
    Image.asset('assets/avatars/4.png'),
    Image.asset('assets/avatars/5.png'),
  ];

  @override
  Widget build(BuildContext context) {
    print(cache.ktoro.toString() + "############");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        title: 'Sk??adappka',
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appTheme().primaryColor,
          //entry point to your app scaffold blank display
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 50,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: appTheme().primaryColor,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: appTheme().primaryColor,
            title: GradientText(
              'sk??adappka',
              colors: [Colors.lightBlue[300], Color.fromRGBO(178, 150, 255, 1)],
              style: TextStyle(
                fontFamily: GoogleFonts.workSans().fontFamily,
                fontWeight: FontWeight.normal,
                fontSize: 34,
                letterSpacing: 2,
              ),
            ),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity > 0) {
                //w prawo
                cache.ktoro -= 1;
                if (cache.ktoro < 0) cache.ktoro = 0;
                setState(() {});
              }
              if (details.primaryVelocity < 0) {
                //w lewo
                cache.ktoro += 1;
                if (cache.ktoro > 4) cache.ktoro = 4;
                setState(() {});
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(45, 45, 45, 1),
                          Color.fromRGBO(59, 55, 68, 1)
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: viewReturner(cache.ktoro)),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: cache.ktoro,
            color: Colors.lightBlue[300],
            backgroundColor: Color.fromRGBO(59, 55, 68, 1),
            animationDuration: Duration(milliseconds: 300),
            height: 50,
            items: <Widget>[
              Icon(Icons.star_rate_outlined, color: Colors.white),
              Icon(Icons.edit, color: Colors.white),
              Icon(Icons.add, color: Colors.white),
              Icon(Icons.leaderboard, color: Colors.white),
              if (cache.czyZalogowany == "czyZalogowany=false" ||
                  Skladapka.connectivityResult == ConnectivityResult.none)
                Icon(Icons.account_circle_rounded, color: Colors.white)
              else
                Container(
                  height: 30,
                  width: 30,
                  child: ClipRRect(
                    child: FutureBuilder(
                      future: getAvatarNumber(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done)
                          return avatarList[snapshot.data];
                        else
                          return Container();
                      },
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
            ],
            letIndexChange: (int index) {
              if (Skladapka.connectivityResult == ConnectivityResult.none &&
                  index == 4) {
                Fluttertoast.showToast(
                    msg: "Brak po????czenia z internetem",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2);
                return false;
              } else
                return true;
            },
            onTap: (int index) {
             _onItemTapped(index);
            },
          ),
        ));
  }
}
