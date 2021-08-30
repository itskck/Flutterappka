import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/Firebase/Gpu.dart';
class Glowna extends StatefulWidget {
  Glowna({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Glowna createState() => _Glowna();
}
class _Glowna extends State<Glowna>{
  User _firebaseUser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text(
              'Kim jestem',
              style: TextStyle(color: Colors.white),
            ),
              onPressed: (){
                print(_firebaseUser.uid);
              }
          ),
        ],

      ),
      );
  }
}