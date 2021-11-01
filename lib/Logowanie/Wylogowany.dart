import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
import 'package:skladappka/Firebase/addToDatabase/addToDatabase.dart';

class Wylogowany extends StatefulWidget {
  final Function toggleView;
  Wylogowany({this.toggleView});

  @override
  _Wylogowany createState() => _Wylogowany();
}

class _Wylogowany extends State<Wylogowany> {
  final doLogowanie _auth = doLogowanie();
  final _formKey = GlobalKey<FormState>();
  final addNickToDatabase _add = addNickToDatabase();
  final TextStyle style = TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.workSans().fontFamily);
  String nick = '';
  String error = '';
  final file = fileReader();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Zarejestruj się',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: GoogleFonts.workSans().fontFamily,
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('E-mail', style: style),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      validator: (val) => val.isEmpty ? 'Wprowadz email' : null,
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: style,
                      decoration: InputDecoration(
                          hintText: "Wprowadź adres e-mail",
                          hintStyle: style,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                          prefixIcon: Icon(Icons.email, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hasło', style: style),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 8
                          ? 'Wprowadz haslo conajmniej 8 znakow'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: style,
                      decoration: InputDecoration(
                          hintText: "Wprowadź hasło",
                          hintStyle: style,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                          prefixIcon: Icon(Icons.lock, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    alignment: Alignment.center,
                    child: Text(
                      'ZAREJESTRUJ',
                      style: style,
                    ),
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    await _auth.deleteAnonym();
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                      result = await _auth.Anonim();
                      globalna.czyZalogowany = "czyZalogowany=false";
                    } else {
                      file.save("czyZalogowany=true");
                      email.runes.forEach((int element) {
                        var character = new String.fromCharCode(element);
                        if (character == '@') {
                          _add.updateUserData(
                              nick, FirebaseAuth.instance.currentUser.uid);
                        } else {
                          nick += character;
                        }
                      });
                      globalna.czyZalogowany = "czyZalogowany=true";
                    }
                  }
                }),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Masz już konto? ', style: style),
                  Text(
                    'Zaloguj się',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () => widget.toggleView(),
            ),
          ],
        ),
      ),
    );
  }
}
