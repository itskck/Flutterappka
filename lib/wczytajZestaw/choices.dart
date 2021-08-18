import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;
class choices extends StatefulWidget {
  choices({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _choices createState() => _choices();
}
class _choices extends State<choices>{
  int nextPage=0;   

  
  
  Widget optionButton(String text,int next)
  {
    
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
      
      height: 50,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(240, 84, 84, 1)),
      ),
      child: Text(text,
      style: TextStyle(
        foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.8
                    ..color = Colors.red
      ),
      ),
    ));
  }
  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              optionButton('Wczytaj zapisany zestaw',1),
              SizedBox(height: 20,),
              optionButton('Wczytaj z kodu',2)
          ],
        ),
      );
  }
}