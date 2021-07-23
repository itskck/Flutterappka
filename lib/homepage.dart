import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Homepage{  
  Future<String> printdb() async {
    WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
    var tekst;
    final ref = FirebaseDatabase.instance.reference();
    ref.once().then((DataSnapshot data){
      tekst= data.value;
    });
    return tekst.toString();
  }  
}