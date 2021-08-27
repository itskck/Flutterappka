import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
class haveAcc extends StatefulWidget {

  final Function toggleView;
  haveAcc({ this.toggleView });

  @override
  _haveAcc createState() => _haveAcc();
}

class _haveAcc extends State<haveAcc>{
  String email = '';
  String password = '';

  final doLogowanie _auth = doLogowanie();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final file=fileReader();

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
              validator: (val) => val.length < 8 ? 'Wprowadzono mniej niz 8 znakow' : null,
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Zaloguj',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Nie udalo sie zalogowac z tymi danymi';
                      });
                      result = await _auth.Anonim();
                    }
                    else{
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
                'Nie mam konta',
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