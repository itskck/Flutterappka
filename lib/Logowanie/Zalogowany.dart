import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Zalogowany extends StatefulWidget {
  Zalogowany({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Zalogowany createState() => _Zalogowany();
}

class _Zalogowany extends State<Zalogowany>{
  final doLogowanie _auth = doLogowanie();
  final file=fileReader();
  void logout() async{
    await _auth.wylogui();
    file.save("czyZalogowany=false");
    globalna.czyZalogowany="czyZalogowany=false";
    dynamic result = await _auth.Anonim();
    print(result);
  }
  Widget build(BuildContext context) {
    return Center(
        child: FlatButton(
          child: Text("Wyloguj"),
          onPressed: () async{
            logout();
          },
        ),
      );
  }
}