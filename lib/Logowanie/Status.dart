
import 'package:skladappka/Logowanie/Zalogowany.dart';
import 'package:skladappka/Logowanie/Wylogowany.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Logowanie/haveAcc.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return haveAcc(toggleView:  toggleView);
    } else {
      return Wylogowany(toggleView:  toggleView);
    }
  }
}