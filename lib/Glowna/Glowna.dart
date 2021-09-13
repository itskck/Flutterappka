import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Glowna extends StatefulWidget {
  Glowna({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Glowna createState() => _Glowna();
}

class _Glowna extends State<Glowna> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult connectivityResult;

  @override
  void initState() {
    super.initState();
    print('ao');
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
        print('object');
  }

  @override
  dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  void updateConnectionStatus(ConnectivityResult result){
    setState(() {
      print(result);
      connectivityResult = result;
    });
  }

  User _firebaseUser = FirebaseAuth.instance.currentUser;

  Widget internetIcon() {
    if (connectivityResult == ConnectivityResult.none)
      return Icon(
        Icons.wifi,
        color: Colors.red,
      );
    else
      return Icon(Icons.wifi, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Witaj w składappce!"),
          internetIcon(),
          Text(connectivityResult.toString()),
        ],
      ),
    );
  }
}
