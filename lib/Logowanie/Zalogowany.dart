import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:google_fonts/google_fonts.dart';

class Zalogowany extends StatefulWidget {
  Zalogowany({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Zalogowany createState() => _Zalogowany();
}

class _Zalogowany extends State<Zalogowany> {
  final doLogowanie _auth = doLogowanie();
  final file = fileReader();
  void logout() async {
    await _auth.wylogui();
    file.save("czyZalogowany=false");
    globalna.czyZalogowany = "czyZalogowany=false";
    dynamic result = await _auth.Anonim();
    print(result);
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Row(
              children: [
                Container(
                  height: 70,
                  child: Stack(fit: StackFit.passthrough, children: [
                    ClipRRect(
                        child: Image.asset('assets/avatars/1.png'),
                        borderRadius: BorderRadius.circular(100)),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment(1.2, 1.2),
                        child: Container(
                          
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 84, 84, 1),
                            borderRadius: BorderRadius.circular(100))
                          ,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Witaj, twoja_stara8',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
