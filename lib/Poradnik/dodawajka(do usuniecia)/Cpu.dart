
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Poradnik/dodawajka(do usuniecia)/dodawajka.dart';
import 'package:skladappka/main.dart';

import 'coDodajesz.dart';

class Cpu extends StatefulWidget {

  @override
  _CpuState createState() => _CpuState();
}

class _CpuState extends State<Cpu> {
  TextEditingController benchscoreControl = TextEditingController();
  TextEditingController modelControl = TextEditingController();
  TextEditingController clockControl = TextEditingController();
  TextEditingController coresControl = TextEditingController();
  TextEditingController hasGpuControl = TextEditingController();
  TextEditingController manufacturerControl = TextEditingController();
  TextEditingController socketControl = TextEditingController();
  TextEditingController tdpControl = TextEditingController();
  TextEditingController threadsControl = TextEditingController();
  TextEditingController yearControl = TextEditingController();
  final dodawajka dodaj=dodawajka();
  bool isCoolerIncluded=false;
  bool isUnlocked=false;
  String manufacturer = '';
  String model = '';
  String benchscore = '';
  String clock = '';
  String cores = '';
  String hasGpu = '';
  String socket = '';
  String tdp = '';
  String threads = '';
  String year = '';
  final TextStyle style = TextStyle(
      color: Colors.white, fontFamily: GoogleFonts.workSans().fontFamily);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Text(
                'BenchScore: ',
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
                      controller: benchscoreControl,
                      onChanged: (val) {
                        setState(() => benchscore = val);
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
                'Clock: ',
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
                      controller: clockControl,
                      onChanged: (val) {
                        setState(() => clock = val);
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
                'Cores: ',
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
                      controller: coresControl,
                      onChanged: (val) {
                        setState(() => cores = val);
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
                'hasGpu: ',
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
                      controller: hasGpuControl,
                      onChanged: (val) {
                        setState(() => hasGpu = val);
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
                'isCoolerIncluded: ',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Checkbox(value: isCoolerIncluded,
                  onChanged: (bool value){
                    setState(() {
                      isCoolerIncluded=value;
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Text(
                'isUnlocked: ',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Checkbox(value: isUnlocked,
                  onChanged: (bool value){
                    setState(() {
                      isUnlocked=value;
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              Text(
                'manufacturer: ',
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
                'model: ',
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
          Row(
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
                      controller: socketControl,
                      onChanged: (val) {
                        setState(() => socket = val);
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
                'tdp: ',
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
                      controller: tdpControl,
                      onChanged: (val) {
                        setState(() => tdp = val);
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
                'threads: ',
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
                      controller: threadsControl,
                      onChanged: (val) {
                        setState(() => threads = val);
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
                'year: ',
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
                      controller: yearControl,
                      onChanged: (val) {
                        setState(() => year = val);
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
          GestureDetector(
              onTap: () async{
                await dodaj.dodajCpu(benchscore,clock,cores,hasGpu,manufacturer,model,socket,tdp,threads,year,isUnlocked,isCoolerIncluded);

                setState(() {
                  benchscoreControl.clear();
                  clockControl.clear();
                  coresControl.clear();
                  hasGpuControl.clear();
                  manufacturerControl.clear();
                  modelControl.clear();
                  socketControl.clear();
                  tdpControl.clear();
                  threadsControl.clear();
                  yearControl.clear();
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
      ),)
    );
  }
}
