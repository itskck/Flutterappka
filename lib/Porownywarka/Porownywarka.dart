import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:skladappka/Firebase/getFromDatabase/getFromCode.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:skladappka/main.dart';
import 'package:skladappka/Porownywarka/comparison.dart';
import 'package:skladappka/Porownywarka/dialogBuilderForCompare.dart';
import 'package:skladappka/Porownywarka/dialogWidgetForCompare.dart';

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
  static String uid, uid2;
  static List<Drive> extradisk,extradisk2;
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

  Future<void> setValues(int lp, String value) async {
    if (lp == 0) {
      Porownywarka.chosenCpu = await getFromCode(code: value).getCpu();
      Porownywarka.chosenPsu = await getFromCode(code: value).getPsu();
      Porownywarka.chosenMtb = await getFromCode(code: value).getMotherboard();
      Porownywarka.chosenDrive = await getFromCode(code: value).getDrive();
      Porownywarka.chosenRam = await getFromCode(code: value).getRam();
      Porownywarka.chosenCase = await getFromCode(code: value).getCase();
      Porownywarka.chosenGpu = await getFromCode(code: value).getGpu();
      Porownywarka.chosenCooler = await getFromCode(code: value).getCooler();
      Porownywarka.uid = await getFromCode(code: value).getUid();
      Porownywarka.extradisk=await getFromCode(code: value).setExtra();
    } else {
      Porownywarka.chosenCpu2 = await getFromCode(code: value).getCpu();
      Porownywarka.chosenPsu2 = await getFromCode(code: value).getPsu();
      Porownywarka.chosenMtb2 = await getFromCode(code: value).getMotherboard();
      Porownywarka.chosenDrive2 = await getFromCode(code: value).getDrive();
      Porownywarka.chosenRam2 = await getFromCode(code: value).getRam();
      Porownywarka.chosenCase2 = await getFromCode(code: value).getCase();
      Porownywarka.chosenGpu2 = await getFromCode(code: value).getGpu();
      Porownywarka.chosenCooler2 = await getFromCode(code: value).getCooler();
      Porownywarka.uid2 = await getFromCode(code: value).getUid();
      Porownywarka.extradisk2=await getFromCode(code: value).setExtra();
    }
  }

  Widget left(bool isLeftChoosen) {
    List<Widget> children = [
      Text(
        'Wczytaj zestaw z kodu',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: GoogleFonts.workSans().fontFamily,
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w100,
        ),
      ),
      TextField(
        onSubmitted: (String value) async {
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
              print('dobry kodzik lewo');
              await setValues(0, value);

              setState(() {
                isLeftChosen = true;
              });
            }
          }
        },
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Wpisz kod zestawu',
          counterText: "",
          
          hintStyle: TextStyle(            
            fontFamily: GoogleFonts.workSans().fontFamily,
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w100,
          ),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                    child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color.fromRGBO(45, 45, 45, 1),
                        ),
                        width: 150,
                        height: 50,
                        child: children[currentChild]),
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    if(Skladapka.connectivityResult==ConnectivityResult.none)
                      Fluttertoast.showToast(msg: "Brak połączenia z internetem",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2);
                    else {
                      if (globalna.czyZalogowany == "czyZalogowany=false") {
                        Fluttertoast.showToast(msg: "Musisz się zalogować",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2);
                      } else {
                        await dialogWidgetForCompare().showPopup(context,
                            0); //W zaleznosci czy bedzie wybrana lewa czy prawa wartosc bedzie sie zmieniala z 0 na 1
                        // print(Porownywarka.chosenCpu[0]);

                      }
                      if ((isRightChosen == true &&
                              (Porownywarka.chosenCpu != null &&
                                  Porownywarka.chosenCpu2 != null)) ||
                          (isRightChosen == false &&
                              (Porownywarka.chosenCpu != null ||
                                  Porownywarka.chosenCpu2 != null)))
                        setState(() {
                          isLeftChosen = true;
                        });
                    }
                    if ((isRightChosen == true &&
                            (Porownywarka.chosenCpu != null &&
                                Porownywarka.chosenCpu2 != null)) ||
                        (isRightChosen == false &&
                            (Porownywarka.chosenCpu != null ||
                                Porownywarka.chosenCpu2 != null)))
                      setState(() {
                        isLeftChosen = true;
                      });
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Wczytaj zapisany zestaw',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GoogleFonts.workSans().fontFamily,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      else
        return Container(
          width: 150,
          height: 150,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(142, 223, 255, 1),
              Color.fromRGBO(255, 0, 140, 1)
            ]),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(45, 45, 45, 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.check,
              size: 70,
              color: Colors.white,
            ),
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
          fontFamily: GoogleFonts.workSans().fontFamily,
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w100,
        ),
      ),
      TextField(
        onSubmitted: (String value) async {
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
              print('dobry kodzik prawo');
              await setValues(1, value);

              setState(() {
                isRightChosen = true;
              });
            }
          }
        },
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Wpisz kod zestawu',
          counterText: "",
          hintStyle: TextStyle(
            fontFamily: GoogleFonts.workSans().fontFamily,
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w100,
          ),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                    child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color.fromRGBO(45, 45, 45, 1),
                        ),
                        width: 150,
                        height: 50,
                        child: children[currentChild]),
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    if(Skladapka.connectivityResult==ConnectivityResult.none)
                      Fluttertoast.showToast(msg: "Brak połączenia z internetem",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2);
                    else {
                      if (globalna.czyZalogowany == "czyZalogowany=false") {
                        Fluttertoast.showToast(msg: "Musisz się zalogować",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2);
                      } else {
                        await dialogWidgetForCompare().showPopup(context,
                            1); //W zaleznosci czy bedzie wybrana lewa czy prawa wartosc bedzie sie zmieniala z 0 na 1
                        // print(Porownywarka.chosenCpu[0]);
                      }
                      if ((isLeftChosen == true &&
                              (Porownywarka.chosenCpu != null &&
                                  Porownywarka.chosenCpu2 != null)) ||
                          (isLeftChosen == false &&
                              (Porownywarka.chosenCpu != null ||
                                  Porownywarka.chosenCpu2 != null)))
                        setState(() {
                          isRightChosen = true;
                        });
                    }
                    if ((isLeftChosen == true &&
                            (Porownywarka.chosenCpu != null &&
                                Porownywarka.chosenCpu2 != null)) ||
                        (isLeftChosen == false &&
                            (Porownywarka.chosenCpu != null ||
                                Porownywarka.chosenCpu2 != null)))
                      setState(() {
                        isRightChosen = true;
                      });
                  },
                  child:  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(142, 223, 255, 1),
                          Color.fromRGBO(255, 0, 140, 1)
                        ])),
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Wczytaj zapisany zestaw',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GoogleFonts.workSans().fontFamily,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      else
        return Container(
          width: 150,
          height: 150,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(142, 223, 255, 1),
              Color.fromRGBO(255, 0, 140, 1)
            ]),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(45, 45, 45, 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.check,
              size: 70,
              color: Colors.white,
            ),
          ),
        );
    }

    ;
    setState(() {});
    return Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child());
  }

  @override
  Widget build(BuildContext context) {
    if (isLeftChosen && isRightChosen) return Comparison();
    //build context gives the layout, when you build widget it will always have this line
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Porównywanie zestawów',
              textAlign: TextAlign.center,
              style: TextStyle(
                  
                  fontFamily: GoogleFonts.workSans().fontFamily,                  
                  fontWeight: FontWeight.normal,
                  fontSize: 38,
                  letterSpacing: 2,
                  color: Colors.white
                  ),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1,vertical: 0),
                child: Text('Wybierz dwa dowolne zestawy, a następnie porównaj ich komponenty',
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
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
            left(isLeftChosen),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                )),
            right(isRightChosen),
      ],
    ),
          SizedBox(height: 170,)
          ],

        ));
  }
}
