//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skladappka/Firebase/DoLogowania/doRejestracji.dart';
import 'package:skladappka/Cache.dart' as cache;
import 'package:skladappka/config/OperacjePliki.dart';

class doLogowanie {
  final FirebaseAuth _autoryzacja = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final file = fileReader();
  final User _firebaseUser = FirebaseAuth.instance.currentUser;

  //anon
  Future Anonim() async { //logowanie jako anonim
    try {
      UserCredential result = await _autoryzacja.signInAnonymously();
      User user = result.user;
      return _uzytkownik(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //funkcja przydzielająca id użytkownika
  doRejestracji _uzytkownik(User user) {
    return user != null ? doRejestracji(uid: user.uid) : null;
  }

  //metoda nasłuchująca strumienia danych w poszukiwaniu zmian id użytkownika
  Stream<doRejestracji> get user {
    return _autoryzacja
        .authStateChanges()
        .map((User user) => _uzytkownik(user));
  }

  //wylogowanie
  Future wylogui() async {
    try {
      return await _autoryzacja.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  //rejestracja e-mailem i hasłem
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _autoryzacja.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _uzytkownik(user);
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Podany adres e-mail jest zajęty lub jest niepoprawny",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2);
      return null;
    }
  }

  //logowanie z użyciem e-maila i hasła
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _autoryzacja.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  //usuwanie zestawów użytkownika
  Future deleteUserBuilds() async {
    var collection = FirebaseFirestore.instance
        .collection("builds")
        .where("uid", isEqualTo: _firebaseUser.uid);
    var snapshot = await collection.get();
    for (var document in snapshot.docs) await document.reference.delete();
  }

  //usuwanie użytkownika
  Future removeUser() async {
    var collection = FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: _firebaseUser.uid);
    var snapshot = await collection.get();
    for (var document in snapshot.docs) await document.reference.delete();
  }

  //usunięcie
  Future deleteUser() async {
    await deleteUserBuilds();
    await removeUser();
    await FirebaseAuth.instance.currentUser.delete();

    await Anonim();
    print(_firebaseUser.uid);
    cache.czyZalogowany = "czyZalogowany=false";
    file.save(cache.czyZalogowany,'loginConfig');
  }

  Future deleteAnonym() async {
    return await _autoryzacja.currentUser.delete();
  }
}
