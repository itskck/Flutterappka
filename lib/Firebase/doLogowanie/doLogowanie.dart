import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/Firebase/doLogowanie/doRejestracji.dart';

class doLogowanie{

  final FirebaseAuth _autoryzacja=FirebaseAuth.instance;

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
  //logowanie
}
