//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/config/fileOperations.dart';

class doLogowanie {
  final FirebaseAuth _autoryzacja = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final file = fileReader();
  final User _firebaseUser = FirebaseAuth.instance.currentUser;

  //anon
  Future Anonim() async {
    try {
      UserCredential result = await _autoryzacja.signInAnonymously();
      User user = result.user;
      return _uzytkownik(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //rejestracja
  doRejestracji _uzytkownik(User user) {
    return user != null ? doRejestracji(uid: user.uid) : null;
  }

  //stream
  Stream<doRejestracji> get user {
    return _autoryzacja
        .authStateChanges()
        .map((User user) => _uzytkownik(user));
  }

  Future wylogui() async {
    try {
      return await _autoryzacja.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _autoryzacja.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _uzytkownik(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _autoryzacja.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future deleteAccFromUsers() async {
    return userCollection.doc(_autoryzacja.currentUser.uid).delete();
  }

  Future deleteUserBuilds() async {
    var collection = FirebaseFirestore.instance
        .collection("builds")
        .where("uid", isEqualTo: _firebaseUser.uid);
    var snapshot = await collection.get();
    for (var document in snapshot.docs) await document.reference.delete();
  }

  Future deleteUser() async {
    await deleteUserBuilds();
    await FirebaseAuth.instance.currentUser.delete();
    await FirebaseAuth.instance.signOut();
    await Anonim();
    print(_firebaseUser.uid);
    globalna.czyZalogowany = "czyZalogowany=false";
    file.save(globalna.czyZalogowany);
  }

  Future deleteAnonym() async {
    return await _autoryzacja.currentUser.delete();
  }
}
