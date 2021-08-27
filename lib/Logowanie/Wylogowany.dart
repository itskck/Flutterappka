import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';

class Wylogowany extends StatefulWidget {

  final Function toggleView;
  Wylogowany({ this.toggleView });

  @override
  _Wylogowany createState() => _Wylogowany();
}

class _Wylogowany extends State<Wylogowany>{
  final doLogowanie _auth = doLogowanie();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final file=fileReader();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Wprowadz email' : null,
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 8 ? 'Wprowadz haslo conajmniej 8 znakow' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Zarejestruj',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await _auth.wylogui();
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                        result = await _auth.Anonim();
                        globalna.czyZalogowany="czyZalogowany=false";
                      }
                      else {
                        file.save("czyZalogowany=true");
                        globalna.czyZalogowany = "czyZalogowany=true";
                      }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Mam juz konto',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => widget.toggleView(),
              ),
            ],
          ),
        ),
      );
  }
}