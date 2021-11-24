import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Case extends StatefulWidget {
  @override
  _CaseState createState() => _CaseState();
}

class _CaseState extends State<Case> {
  TextEditingController manufacturerControl = TextEditingController();
  TextEditingController standardControl = TextEditingController();
  String manufacturer = '';
  String model = '';
  String standardText = '';
  double iloscStandard = 1;
  List<String> stanard;
  final TextStyle style = TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.workSans().fontFamily);

  @override
  initState() {
    super.initState();
    stanard = new List<String>();
  }

  Widget addStandard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Stanard: ',
          style: TextStyle(color: Colors.black),
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
                controller: standardControl,
                onChanged: (val) {
                  setState(() => standardText = val);
                },
                onFieldSubmitted: (val) {
                  stanard.add(val);
                  print(stanard.length);
                  standardText = '';
                  val = 'jest git';
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
                style: TextStyle(color: Colors.black),
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
                    onFieldSubmitted: (val) {
                      stanard.add(val);
                      print(stanard.length);
                      standardText = '';
                      val = 'jest git';
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
                style: TextStyle(color: Colors.black),
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
                      controller: manufacturerControl,
                      onChanged: (val) {
                        setState(() => model = val);
                      },
                      onFieldSubmitted: (val) {
                        stanard.add(val);
                        print(stanard.length);
                        standardText = '';
                        val = 'jest git';
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
            style: TextStyle(color: Colors.black),
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
          for (int i = 0; i < iloscStandard.toInt(); i++) addStandard(),
        ],
      ),
    );
  }
}
