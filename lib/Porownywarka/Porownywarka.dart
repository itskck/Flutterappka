import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/Firebase/getFromDatabase/getFromCode.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:skladappka/Porownywarka/dialogBuilderForCompare.dart';
import 'package:skladappka/Porownywarka/dialogWidgetForCompare.dart';
import 'package:skladappka/Porownywarka/comparison.dart';

class Porownywarka extends StatefulWidget {
  Porownywarka({Key key, this.title}) : super(key: key);

  final String title;

  static Cpu chosenCpu, chosenCpu2;
  static Psu chosenPsu, chosenPsu2;
  static Motherboard chosenMtb, chosenMtb2;
  static Drive chosenDrive, chosenDrive2;
  static Ram chosenRam, chosenRam2;
  static Case chosenCase, chosenCase2;
  static Gpu chosenGpu, chosenGpu2;
  static Cooler chosenCooler, chosenCooler2;

  @override
  _Porownywarka createState() => _Porownywarka();
}

class _Porownywarka extends State<Porownywarka> {
  // static List<Object> cpus,rams,gpus,psus,drive;
  List<Object> components;
  List<double> ranking;
  List<Widget> list1, list2;
  bool isLeftChosen = false, isRightChosen = false;
  String code;

  final dialogBuilderForCompare compare = dialogBuilderForCompare();
  int currentChild = 0;

  Future<void> generateLists() {
    //czekasz az po lewo i po prawo w porównywarce będzie wybrany zestaw albo wpisany kod
    //w sumie trzeba jakiś zrobić ✓ że wybrany został do porównania zestaw pomyślnie

    //GENERACJA LISTY
    //generujesz po jednym indexie z list1 i list2,
    //np. index 0 to cpu w list1 i w list 2,
    //sprawdzasz ktory jest lepszy, czy ten z list1 czy z list2,
    //ustawiasz widget score() zeby sie wyswietlal albo też nie,
    //generujesz tak całą liste, wyświetlasz, profit.
  }

  Widget left(bool isLeftChoosen) {
    List<Widget> children = [
      Text(
        'Wczytaj zestaw z kodu',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'coolvetica',
          fontSize: 17,
          fontWeight: FontWeight.w100,
        ),
      ),
      TextField(
        onSubmitted: (String value) async {
          if (await getFromCode(code: value).corrCode() == false) {
            print("Slaby kodzik");
          } else {
            print('dobry kodzik lewo');
            setState(() {
                   isLeftChosen=true;       
                        });
            
            Porownywarka.chosenCpu = await getFromCode(code: value).getCpu();
            Porownywarka.chosenPsu = await getFromCode(code: value).getPsu();
            Porownywarka.chosenMtb =
                await getFromCode(code: value).getMotherboard();
            Porownywarka.chosenDrive =
                await getFromCode(code: value).getDrive();
            Porownywarka.chosenRam = await getFromCode(code: value).getRam();
            Porownywarka.chosenCase = await getFromCode(code: value).getCase();
            Porownywarka.chosenGpu = await getFromCode(code: value).getGpu();
            Porownywarka.chosenCooler =
                await getFromCode(code: value).getCooler();
          }
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

    Widget child() {
      if (!isLeftChoosen)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      currentChild = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(240, 84, 84, 1), width: 2),
                    ),
                    child: children[currentChild],
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    if (globalna.czyZalogowany == "czyZalogowany=false") {
                      print("uzytkownik niezalogowany");
                    } else {
                      await dialogWidgetForCompare().showPopup(context,
                          0); //W zaleznosci czy bedzie wybrana lewa czy prawa wartosc bedzie sie zmieniala z 0 na 1
                      // print(Porownywarka.chosenCpu[0]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(240, 84, 84, 1), width: 2),
                    ),
                    child: Text(
                      
                      'Wczytaj zapisany zestaw',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        
                          fontFamily: 'coolvetica',
                          fontSize: 17,
                          fontWeight: FontWeight.w100),
                    ),
                  )),
            ],
          ),
        );
      else
        return  Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1
            )
          ),
          child: Icon(
            Icons.check,
            size: 70,
            
          ),
        );
    }

    ;
    setState(() {});
    return Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child());
  }

    Widget right(bool isRightChoosen) {
    List<Widget> children = [
      Text(
        'Wczytaj zestaw z kodu',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'coolvetica',
          fontSize: 17,
          fontWeight: FontWeight.w100,
        ),
      ),
      TextField(
        onSubmitted: (String value) async {
          if (await getFromCode(code: value).corrCode() == false) {
            print("Slaby kodzik");
          } else {
            setState(() {
                   isRightChosen=true;       
                        });
            Porownywarka.chosenCpu2 = await getFromCode(code: value).getCpu();
            Porownywarka.chosenPsu2 = await getFromCode(code: value).getPsu();
            Porownywarka.chosenMtb2 =
                await getFromCode(code: value).getMotherboard();
            Porownywarka.chosenDrive2 =
                await getFromCode(code: value).getDrive();
            Porownywarka.chosenRam2 = await getFromCode(code: value).getRam();
            Porownywarka.chosenCase2 = await getFromCode(code: value).getCase();
            Porownywarka.chosenGpu2 = await getFromCode(code: value).getGpu();
            Porownywarka.chosenCooler2 =
                await getFromCode(code: value).getCooler();
          }
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

    Widget child() {
      if (!isRightChosen)
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      currentChild = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(240, 84, 84, 1), width: 2),
                    ),
                    child: children[currentChild],
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    if (globalna.czyZalogowany == "czyZalogowany=false") {
                      print("uzytkownik niezalogowany");
                    } else {
                      await dialogWidgetForCompare().showPopup(context,
                          1); //W zaleznosci czy bedzie wybrana lewa czy prawa wartosc bedzie sie zmieniala z 0 na 1
                      // print(Porownywarka.chosenCpu[0]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(240, 84, 84, 1), width: 2),
                    ),
                    child: Text(
                      'Wczytaj zapisany zestaw',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'coolvetica',
                          fontSize: 17,
                          fontWeight: FontWeight.w100),
                    ),
                  )),
            ],
          ),
        );
      else
        return  Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1
            )
          ),
          child: Icon(
            Icons.check,
            size: 70,
            
          ),
        );
    };
    setState(() {});
    return Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child());
  }

  @override
  Widget build(BuildContext context) {
    if(isLeftChosen&&isRightChosen) return Comparison();
    //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        left(isLeftChosen),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: 1,
            child: Container(
              color: Colors.red,
            )),
        right(isRightChosen),
      ],
    ));
  }
}
