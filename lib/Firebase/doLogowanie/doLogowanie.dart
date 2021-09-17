import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';

class doLogowanie{

  final FirebaseAuth _autoryzacja=FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //anon
  Future Anonim() async {
    try{
      UserCredential result=await _autoryzacja.signInAnonymously();
      User user=result.user;
      return _uzytkownik(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //rejestracja
  doRejestracji _uzytkownik(User user){
    return user!=null ? doRejestracji(uid: user.uid) : null;
  }

  //stream
  Stream<doRejestracji>get user{
    return _autoryzacja
        .authStateChanges()
        .map((User user) => _uzytkownik(user));
  }

  Future wylogui() async{
    try{
      return await _autoryzacja.signOut();
    }
    catch (error){
      print(error.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result=await _autoryzacja.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _uzytkownik(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _autoryzacja.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future deleteAccFromUsers() async{
    return userCollection.doc(_autoryzacja.currentUser.uid).delete();
  }

  /*Future deleteUser(String email, String password) async {
    try {
      User user =  _autoryzacja.currentUser;
      AuthCredential credentials =
      EmailAuthProvider.credential(email: email, password: password);
      print(user);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user.uid).deleteuser(); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  } */

Future deleteAnonym()async {
   return await _autoryzacja.currentUser.delete();
  }
}
