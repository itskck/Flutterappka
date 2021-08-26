import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Globalne.dart' as globalna;

class Porownywarka extends StatefulWidget {
  Porownywarka({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Porownywarka createState() => _Porownywarka();
}

class _Porownywarka extends State<Porownywarka> {
  String code;
  int currentChild = 0;
  List<Widget> children = [
    Text(
      'Wczytaj zestaw z kodu',
      style: TextStyle(
        fontFamily: 'coolvetica',
        fontSize: 17,
        fontWeight: FontWeight.w100,
      ),
    ),
    TextField(
      onSubmitted: (String value) {
        //switch page
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Wpisz kod zestawu',
        counterText: "",
      ),
      autofocus: true,
      enableInteractiveSelection: false,
      maxLines: 1,
      maxLength: 5,
    )
  ];

  Widget codeOptionButton() {
    return GestureDetector(
        onTap: () {
          setState(() {
            currentChild = 1;
          });
        },
        child: Container(
          height: 50,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(240, 84, 84, 1), width: 2),
          ),
          child: children[currentChild],
        ));
  }

  Widget savedButton() {
    return GestureDetector(
        onTap: () {},
        child: Container(
          height: 50,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(240, 84, 84, 1), width: 2),
          ),
          child: Text(
            'Wczytaj zapisany zestaw',
            style: TextStyle(
                fontFamily: 'coolvetica',
                fontSize: 17,
                fontWeight: FontWeight.w100),
          ),
        ));
  }
  Widget buttons(){
    return Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        codeOptionButton(),
        SizedBox(height: 20,),
        savedButton(),
      ],
    ));
  }

  Widget leftChild() {
    return Container();
  }

  Widget rightChild() {
    return Container();
  }

  
  @override
  Widget build(BuildContext context) {
    //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2 - 0.5,
          child: buttons(),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 170,
            width: 1,
            child: Container(
              color: Colors.red,
            )),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2 - 0.5,
          child: buttons(),
        )
      ],
    ));
  }
}
