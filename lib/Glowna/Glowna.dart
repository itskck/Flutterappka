import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:skladappka/main.dart';

class Glowna extends StatefulWidget {
  Glowna({Key key, this.title}) : super(key: key);
  static StreamSubscription<ConnectivityResult> connectivitySubscription;
  final String title;

  @override
  _Glowna createState() => _Glowna();
}

class _Glowna extends State<Glowna> {
  static Connectivity _connectivity = Connectivity();

  static ConnectivityResult connectivityResult = ConnectivityResult.none;
  User _firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    print('ao');
    Glowna.connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    print('object');
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectivityResult = result;
    });
  }
  bool internetIcon() {
    if (Skladapka.connectivityResult == ConnectivityResult.none)
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
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).accentColor)),
          child: Text(
            num.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SizedBox(
            width: 20,
            height: 1,
            child: Container(color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color wifiColor;
    String wifiStatus;
    if(internetIcon()){
      wifiColor=Colors.green;
      wifiStatus="Połączono z siecią!";
    }
    else{
      wifiColor=Colors.red;
      wifiStatus="Oczekiwanie na połączenie z siecią...";
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Witaj w składappce!',
              style: TextStyle(
                  fontFamily: 'coolvetica',
                  fontWeight: FontWeight.normal,
                  fontSize: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 250,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    numberWidget(1),
                    Text('Połącz się z internetem, żeby korzystać z aktualnej bazy komponentów',
                      textAlign: TextAlign.center,),

                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Icon(Icons.wifi_sharp, color: wifiColor,size: 30,)
                    ),
                    Text(wifiStatus,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    numberWidget(2),
                    Text('Dodaj zestaw lub edytuj już istniejący w zakładach',
                      textAlign: TextAlign.center,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Icon(Icons.edit)
                      ],
                    )

                  ],
                ),
              ),
              Container(
                height: 250,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    numberWidget(3),
                    Text('Porównaj dwa zestawy i dowiedz się, który ma lepsze komponenty w zakładce',
                      textAlign: TextAlign.center,),
                    Icon(Icons.leaderboard)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}