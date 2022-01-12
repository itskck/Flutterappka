import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Porownywarka/OknoDialogoweWidget.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Cache.dart' as cache;
import 'WczytajZestaw.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'Edytuj.dart';
import 'package:skladappka/Firebase/PobierzBazeDanych/PobierzKod.dart';
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
          fontFamily: GoogleFonts.workSans().fontFamily,    
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w100,
      ),),
      TextField(
        onSubmitted: (String value) async{
          if(Skladapka.connectivityResult==ConnectivityResult.none)
            Fluttertoast.showToast(msg: "Brak połączenia z internetem",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2);
          else {
          if (await getFromCode(code: value).corrCode() == false) {
            Fluttertoast.showToast(msg: "Błędny kod",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2);
          } else {
            choices.builds = await getFromCode(code: value).getBuild();
            return inicjalizuj(choices.builds);
          }
        }
      } ,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(hintText: 'Wpisz kod zestawu',
        
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.workSans().fontFamily,    
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w100,
      ),
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
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
             Color.fromRGBO(142, 223, 255, 1),
             Color.fromRGBO(255, 0, 140, 1)
          ]
        )
      ),
      child: GestureDetector(
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
         color: Color.fromRGBO(45, 45, 45,1),
         borderRadius: BorderRadius.circular(5),
        ),
        child: children[currentChild],
      )),
    );
  }

   Widget savedButton()
  {    
    return GestureDetector(
      onTap: () async{
        if(Skladapka.connectivityResult==ConnectivityResult.none)
          Fluttertoast.showToast(msg: "Brak połączenia z internetem",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2);
        else {
            if (cache.czyZalogowany == "czyZalogowany=false") {
              Fluttertoast.showToast(msg: "Musisz się zalogować",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2);
            } else {
              await dialogWidgetForCompare().showPopup(context, 0);              
              return inicjalizuj(choices.builds);
            }
          }
        },
      child: Container(      
      height: 50,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
             Color.fromRGBO(142, 223, 255, 1),
             Color.fromRGBO(255, 0, 140, 1)
          ]
        )
      ),
      padding: EdgeInsets.all(2),
      child: Container(
      height: 50,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color.fromRGBO(45, 45, 45,1),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text('Wczytaj zapisany zestaw',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: GoogleFonts.workSans().fontFamily,
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w100
      ),),
      ),
    ));
  }
  @override
  Widget build(BuildContext context) { 
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text('Edycja zestawu',
              style: TextStyle(
                  
                  fontFamily: GoogleFonts.workSans().fontFamily,                  
                  fontWeight: FontWeight.normal,
                  fontSize: 38,
                  letterSpacing: 2,
                  color: Colors.white
                  ),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1,vertical: 0),
                child: Text('Wybierz preferowaną opcje wyboru, a następnie edytuj swój lub skopiuj czyjś zestaw',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.workSans().fontFamily,                  
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    letterSpacing: 1,

                    
                    ),),
              ),
              SizedBox(height: 50,),
              codeOptionButton(),
              SizedBox(height: 20,),
              savedButton(),
              SizedBox(height: 150,)
          ],
        ),
      );
  }
}