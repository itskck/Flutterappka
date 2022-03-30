import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Poradnik/dodawajka/dodawajka.dart';
import 'package:skladappka/main.dart';

import 'Ram.dart';
import 'coDodajesz.dart';

class Cooler extends StatefulWidget {
  @override
  _CoolerState createState() => _CoolerState();
}

class _CoolerState extends State<Cooler> {
  TextEditingController manufacturerControl = TextEditingController();
  TextEditingController modelControl = TextEditingController();
  List<TextEditingController> standardControl;
  String manufacturer = '';
  String model = '';
  String standardText = '';
  double iloscStandard = 1;
  final dodawajka dodaj=dodawajka();
  List<String> stanard;
  final TextStyle style = TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.workSans().fontFamily);

  @override
  initState() {
    super.initState();
    stanard = new List<String>();
    standardControl=new List<TextEditingController>();
    for(int i=0;i<3;i++)
      standardControl.add(TextEditingController());
  }

  Widget addStandard(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Socket: ',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Container(
          width: 200,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(142, 223, 255, 1),
                    Color.fromRGBO(255, 0, 140, 1)
                  ])),
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(45, 45, 45, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: standardControl[i],
                onChanged: (i) {
                  setState(() => standardText = i);
                },
                onFieldSubmitted: (i) {
                  stanard.add(i);
                  print(stanard.length);
                  standardText = '';
                  i = 'jest git';
                },
                style: style,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                    prefixIcon: Icon(Icons.lock, color: Colors.white)),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Align(
                alignment: Alignment.topLeft,
                child:Text(
                  'Manufactuer: ',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      controller: manufacturerControl,
                      onChanged: (val) {
                        setState(() => manufacturer = val);
                      },
                      style: style,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                          prefixIcon: Icon(Icons.lock, color: Colors.white)),
                    )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Model: ',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 200,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      controller: modelControl,
                      onChanged: (val) {
                        setState(() => model = val);
                      },
                      style: style,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                          prefixIcon: Icon(Icons.lock, color: Colors.white)),
                    )
                ),
              ),
            ],
          ),
          Text(
            iloscStandard.toString(),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Slider(
            inactiveColor: Colors.grey,
            activeColor: Colors.pink,
            value: iloscStandard,
            onChanged: (rating) {
              setState(() {
                iloscStandard = rating;
              });
            },
            min: 1,
            max: 3,
            divisions: 2,
          ),
          for (int i = 0; i < iloscStandard.toInt(); i++) addStandard(i),
          GestureDetector(

              onTap: () async{
                for(int i=0;i<iloscStandard.toInt();i++)
                  stanard.add(standardControl[i].text);
                dodaj.dodajCooler(manufacturer, model, stanard);
                setState(() {
                  stanard = new List<String>();
                  manufacturerControl.clear();
                  modelControl.clear();
                  for(int i=0;i<iloscStandard.toInt();i++)
                    standardControl[i].clear();
                  iloscStandard=1;
                });
              },
              child: Container(
                width: 120,
                height: 30,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('Dodaj',
                      style: TextStyle(color: Colors.white,fontSize: 15),

                      textAlign: TextAlign.center,),
                  ),
                ),
              )
          ),
          GestureDetector(
              onTap: () {
                runApp(MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: appTheme(),
                    title: 'Skladapka',
                    home: coDodajesz()));
              },
              child: Container(
                width: 120,
                height: 30,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(45, 45, 45, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('Cofnij',
                      style: TextStyle(color: Colors.white,fontSize: 15),

                      textAlign: TextAlign.center,),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
