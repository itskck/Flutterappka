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

 // static List<Object> cpus,rams,gpus,psus,drive;
  List<Object> components;
  List<double> ranking;
  List<Widget> list1,list2; 
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

  Future<void>generateLists(){
    //czekasz az po lewo i po prawo w porównywarce będzie wybrany zestaw albo wpisany kod
    //w sumie trzeba jakiś zrobić ✓ że wybrany został do porównania zestaw pomyślnie

    //GENERACJA LISTY
    //generujesz po jednym indexie z list1 i list2,
    //np. index 0 to cpu w list1 i w list 2,
    //sprawdzasz ktory jest lepszy, czy ten z list1 czy z list2,
    //ustawiasz widget score() zeby sie wyswietlal albo też nie,
    //generujesz tak całą liste, wyświetlasz, profit.
  }

  Widget score(int gud){

    if(gud==1)
    return Container(
      child: Icon(
      Icons.arrow_upward,
      color: Colors.green,
      ),
      decoration: BoxDecoration(border: Border.all(
        width: 2
      ) ),
    );
    else if(gud==0) return Container();
    else if(gud==2) return Container(
      child: Icon(
      Icons.switch_right,
      color: Colors.yellow,
      ),
      decoration: BoxDecoration(border: Border.all(
        width: 2
      ) ),
    );
  }

  Widget componentBar(String componentName, String bottomText,int gud){

    return Row(children: [
      Column(
        children: [Text(componentName),Text(bottomText)],
      ),
      score(gud)
    ],);
  }

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
            height: MediaQuery.of(context).size.height *0.8,
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
