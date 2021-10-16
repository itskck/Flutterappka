import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:skladappka/main.dart';

class Glowna extends StatefulWidget {
  Glowna({Key key, this.title}) : super(key: key);
  static StreamSubscription<ConnectivityResult> connectivitySubscription;
  static Connectivity _connectivity = Connectivity();
  static ConnectivityResult connectivityResult= ConnectivityResult.none;
  final String title;

  @override
  _Glowna createState() => _Glowna();
}

class _Glowna extends State<Glowna> {

  User _firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    print('ao');
    Glowna.connectivitySubscription =
        Glowna._connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    print('object');
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      Glowna.connectivityResult = result;
    });
  }

  bool internetIcon() {
    if (Glowna.connectivityResult == ConnectivityResult.none)
      return false;
    else
      return true;
  }

  Widget numberWidget(int num) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 20,
            height: 1,
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.white)),
          child: Text(
            num.toString(),
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SizedBox(
            width: 20,
            height: 1,
            child: Container(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    Color wifiColor;
    String wifiStatus;
    if (internetIcon()) {
      wifiColor = Colors.green;
      wifiStatus = "Połączono z siecią!";
    } else {
      wifiColor = Colors.red;
      wifiStatus = "Oczekiwanie na połączenie z siecią...";
    }
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Witaj w składappce!',
              style: TextStyle(
                  fontFamily: GoogleFonts.workSans().fontFamily,
                  fontWeight: FontWeight.normal,
                  //color: Colors.lightBlue[300],
                  color: Colors.white,
                  fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 250,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      numberWidget(1),
                      Text(
                        'Połącz się z internetem, żeby korzystać z aktualnej bazy komponentów',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(
                            Icons.wifi_sharp,
                            color: wifiColor,
                            size: 30,
                          )),
                      Text(
                        wifiStatus,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 250,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      numberWidget(2),
                      Text(
                        'Dodaj zestaw lub edytuj już istniejący w zakładach',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 250,
                  width: 120,
                  decoration: BoxDecoration(

                      color: Color.fromRGBO(45, 45, 45, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      numberWidget(3),
                      Text(
                        'Porównaj dwa zestawy i dowiedz się, który ma lepsze komponenty w zakładce',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.leaderboard,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container (
            child: RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Zaczynajmy!',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute (builder: (context) => Skladapka()));
                }
            ),
          )
        ],

      ),)

    );
  }
}