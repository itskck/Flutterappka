import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'wczytajZestaw.dart';
class choices extends StatefulWidget {
  choices({Key key, this.title}) : super(key: key);

  final String title;

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
        onSubmitted: (String value) {
          //switch page
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
      onTap: (){        
        
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