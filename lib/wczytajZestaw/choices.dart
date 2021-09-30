import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skladappka/Porownywarka/dialogWidgetForCompare.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'wczytajZestaw.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'Edit.dart';
import 'package:skladappka/Firebase/getFromDatabase/getFromCode.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class choices extends StatefulWidget {

  static Builds builds;

  @override
  _choices createState() => _choices();
}
class _choices extends State<choices>{
  int nextPage=0;   
  final wczytajzestaw = wczytajZestaw();
  String code;  
  int currentChild = 0;
  List<Widget> children = [
      Text('Wczytaj zestaw z kodu',
      style: TextStyle(
        fontFamily: 'coolvetica',
        fontSize: 17,
        fontWeight: FontWeight.w100,        
      ),
      ),
      TextField(
        onSubmitted: (String value) async{
          if(Skladapka.connectivityResult==ConnectivityResult.none)
            Fluttertoast.showToast(msg: "Brak połączenia z internetem",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2);
          else {
          if (await getFromCode(code: value).corrCode() == false) {
            Fluttertoast.showToast(msg: "Błędny kod",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2);
          } else {
            choices.builds = await getFromCode(code: value).getBuild();
            return inicjalizuj(choices.builds);
          }
        }
      } ,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: 'Wpisz kod zestawu',
        counterText: "",
        ),
        autofocus: true,
        enableInteractiveSelection: false,
        maxLines: 1,
        maxLength: 5,
      )
    ];
  

  Widget codeOptionButton()
  {    
    return GestureDetector(
      onTap: (){        
        setState(() {
          currentChild=1;
        });
      },
      child: Container(      
      height: 50,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(240, 84, 84, 1),width: 2),
      ),
      child: children[currentChild],
    ));
  }

   Widget savedButton()
  {    
    return GestureDetector(
      onTap: () async{
        if(Skladapka.connectivityResult==ConnectivityResult.none)
          Fluttertoast.showToast(msg: "Brak połączenia z internetem",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2);
        else {
            if (globalna.czyZalogowany == "czyZalogowany=false") {
              Fluttertoast.showToast(msg: "Musisz się zalogować",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2);
            } else {
              await dialogWidgetForCompare().showPopup(context, 0);
              // Navigator.pop(context);//W zaleznosci czy bedzie wybrana lewa czy prawa wartosc bedzie sie zmieniala z 0 na 1
              return inicjalizuj(choices.builds);
            }
          }
        },
      child: Container(      
      height: 50,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(240, 84, 84, 1),width: 2),
      ),
      child: Text('Wczytaj zapisany zestaw',
      style: TextStyle(
        fontFamily: 'coolvetica',
        fontSize: 17,
        fontWeight: FontWeight.w100
      ),),
    ));
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              codeOptionButton(),
              SizedBox(height: 20,),
              savedButton(),
          ],
        ),
      );
  }
}