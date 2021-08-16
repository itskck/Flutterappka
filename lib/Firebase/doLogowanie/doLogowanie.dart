import 'package:firebase_auth/firebase_auth.dart';

class doLogowanie{

  final FirebaseAuth _autoryzacja=FirebaseAuth.instance;

  //anon
  Future Anonim() async {
    try{
      UserCredential result=await _autoryzacja.signInAnonymously();
      User user=result.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //rejestracja

  //logowanie
}
