import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Firebase/Drive.dart';

import '../main.dart';
import 'Porownywarka.dart';
class Comparison extends StatefulWidget {
  const Comparison({Key key}) : super(key: key);

  @override
  _Comparison createState() => _Comparison();
}

class _Comparison extends State<Comparison> {
  final List<Image> avatarList = [
    Image.asset('assets/avatars/1.png'),
    Image.asset('assets/avatars/2.png'),
    Image.asset('assets/avatars/3.png'),
    Image.asset('assets/avatars/4.png'),
    Image.asset('assets/avatars/5.png'),
  ];
  bool isInTBs = false;
  double cpuScore1,
      cpuScore2,
      gpuScore1,
      gpuScore2,
      ramScore1,
      ramScore2,
      driveScore1,
      driveScore2,
      psuScore1,
      psuScore2;
  String username = "", username2 = '';
  int avatarid1 = 0, avatarid2 = 0;

  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: Porownywarka.uid)
        .get()
        .then((QuerySnapshot result) => {
              result.docs.forEach((element) {
                avatarid1 = element['aid'];
                username = element['nick'];
                print('user1 loaded');
              })
            });

    await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: Porownywarka.uid2)
        .get()
        .then((QuerySnapshot result) => {
              result.docs.forEach((element) {
                avatarid2 = element['aid'];
                username2 = element['nick'];
                print('user2 loaded');
              })
            });
  }

  void setScores() {
    print(Porownywarka.extradisk.length);
    print(Porownywarka.extradisk2.length);
    var cpu;
    if (num.parse(Porownywarka.chosenCpu.benchScore) >
        num.parse(Porownywarka.chosenCpu2.benchScore))
      cpu = num.parse(Porownywarka.chosenCpu.benchScore) /
          num.parse(Porownywarka.chosenCpu2.benchScore) *
          100;
    else
      cpu = num.parse(Porownywarka.chosenCpu2.benchScore) /
          num.parse(Porownywarka.chosenCpu.benchScore) *
          100;
    print(cpu);
    cpu-=100;
    cpuScore1 = cpu;
    cpuScore2 = (-1) * (cpu);
    if (num.parse(Porownywarka.chosenCpu.benchScore) <
        num.parse(Porownywarka.chosenCpu2.benchScore)) {
      cpuScore2 = cpu;
      cpuScore1 = (-1) * cpu;
    }
    if (num.parse(Porownywarka.chosenCpu.benchScore) ==
        num.parse(Porownywarka.chosenCpu2.benchScore)) {
      print('if');

      cpuScore1 = 0;
      cpuScore2 = 0;
    }
    print('cpu git');
    var gpu;
    if (num.parse(Porownywarka.chosenGpu.benchScore) >
        num.parse(Porownywarka.chosenGpu2.benchScore))
      gpu = (num.parse(Porownywarka.chosenGpu.benchScore) /
              num.parse(Porownywarka.chosenGpu2.benchScore)) *
          100;
    else
      gpu = (num.parse(Porownywarka.chosenGpu2.benchScore) /
              num.parse(Porownywarka.chosenGpu.benchScore)) *
          100;
    gpu-=100;
    gpuScore1 = gpu;
    gpuScore2 = (-1) * gpu;
    if (num.parse(Porownywarka.chosenGpu.benchScore) <
        num.parse(Porownywarka.chosenGpu2.benchScore)) {
      gpuScore2 = gpu;
      gpuScore1 = (-1) * gpu;
    }
    if (num.parse(Porownywarka.chosenGpu.benchScore) ==
        num.parse(Porownywarka.chosenGpu2.benchScore)) {
      gpuScore1 = 0;
      gpuScore2 = 0;
    }
    print('gpu git');
    var ram;
    if (num.parse(Porownywarka.chosenRam.benchScore) >
        num.parse(Porownywarka.chosenRam2.benchScore))
      ram = num.parse(Porownywarka.chosenRam.benchScore) /
          num.parse(Porownywarka.chosenRam2.benchScore) *
          100;
    else
      ram = num.parse(Porownywarka.chosenRam2.benchScore) /
          num.parse(Porownywarka.chosenRam.benchScore) *
          100;
    ram-=100;
    ramScore1 = ram;
    ramScore2 = (-1) * ram;
    if (num.parse(Porownywarka.chosenRam.benchScore) <
        num.parse(Porownywarka.chosenRam2.benchScore)) {
      ramScore2 = ram;
      ramScore1 = (-1) * ram;
    }
    if (num.parse(Porownywarka.chosenRam.benchScore) ==
        num.parse(Porownywarka.chosenRam2.benchScore)) {
      ramScore1 = 0;
      ramScore2 = 0;
    }
    print('ram git');
    var psu;
    if (num.parse(Porownywarka.chosenPsu.power) >
        num.parse(Porownywarka.chosenPsu2.power))
      psu = num.parse(Porownywarka.chosenPsu.power) /
          num.parse(Porownywarka.chosenPsu2.power) *
          100;
    else
      psu = num.parse(Porownywarka.chosenPsu2.power) /
          num.parse(Porownywarka.chosenPsu.power) *
          100;
    psu-=100;
    psuScore1 = psu;
    psuScore2 = (-1) * psu;
    if (num.parse(Porownywarka.chosenPsu.power) <
        num.parse(Porownywarka.chosenPsu2.power)) {
      psuScore2 = psu;
      psuScore1 = (-1) * psu;
    }
    if (num.parse(Porownywarka.chosenPsu.power) ==
        num.parse(Porownywarka.chosenPsu2.power)) {
      psuScore1 = 0;
      psuScore2 = 0;
    }
    print('psu git');
    var drive;
    if (num.parse(Porownywarka.chosenDrive.capacity) >
        num.parse(Porownywarka.chosenDrive2.capacity))
      drive = num.parse(Porownywarka.chosenDrive.capacity).toDouble() -
          num.parse(Porownywarka.chosenDrive2.capacity).toDouble();
    else
      drive = num.parse(Porownywarka.chosenDrive2.capacity).toDouble() -
          num.parse(Porownywarka.chosenDrive.capacity).toDouble();
    drive-=100;
    driveScore1 = drive;
    driveScore2 = (-1) * drive;
    if (num.parse(Porownywarka.chosenDrive.capacity) <
        num.parse(Porownywarka.chosenDrive2.capacity) * 100) {
      driveScore2 = drive;
      driveScore1 = (-1) * drive;
    }
    if (driveScore1 > 1000 || driveScore2 > 1000) {
      driveScore1 /= 1024;
      driveScore2 /= 1024;
      isInTBs = true;
    } ////////////////////////////////////////////////////////////////////////////////////////sprawdzac czy jest ssd
    if (num.parse(Porownywarka.chosenDrive.capacity) ==
        num.parse(Porownywarka.chosenDrive2.capacity)) {
      driveScore1 = 0;
      driveScore2 = 0;
    }
    print('drive git');
  }

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  Widget componentBar(dynamic comp, Image placeholder, double t_width,
      String side, bool isThere, String compType) {
    TextDirection td;
    String component = comp.manufacturer + " " + comp.model;
    if(component.length>20)component=comp.model;

    Alignment al;
    CrossAxisAlignment crossAxisAlignment;
    double width = dp(t_width, 1);
    String sign, addText = '';

    if (comp is Drive && isInTBs == false)
      sign = ' GB';
    else if (comp is Drive && isInTBs == true)
      sign = ' TB';
    else
      sign = '% SM';

    if (comp is Drive && comp.type == 'HDD') {
      addText = ' HDD';
    }

    var pixelWidth = width;
    if (pixelWidth < 0) pixelWidth = 5;
    if (pixelWidth > 30) pixelWidth = 30;
    Color color;
    if (width > 0) color = Colors.green;
    if (width < 0) color = Colors.grey;
    if (width == 0) color = Colors.grey;

    if (side == 'left') {
      td = TextDirection.ltr;
      al = Alignment.centerLeft;
      crossAxisAlignment = CrossAxisAlignment.start;
    } else {
      td = TextDirection.rtl;
      al = Alignment.centerRight;
      crossAxisAlignment = CrossAxisAlignment.end;
    }

    if (isThere == false)
      return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 60,
      );
    else
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width * 0.5 - 1,
        height: 80,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Container(
              child: Text(
                compType,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    fontFamily: GoogleFonts.workSans().fontFamily,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Container(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              textDirection: td,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )),
                        child: placeholder)),
                LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      AutoSizeText(
                        component,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            fontFamily: GoogleFonts.workSans().fontFamily,
                            color: Colors.white),
                      ),
                      Row(
                        textDirection: td,
                        children: [
                          Container(
                            alignment: al,
                            child: SizedBox(
                              width: pixelWidth.toDouble(),
                              height: 5,
                              child: Container(
                                color: color,
                              ),
                            ),
                          ),
                          if (width > 0)
                            AutoSizeText(
                              ' +$width' + sign,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.workSans().fontFamily,
                                  color: Colors.green),
                              overflow: TextOverflow.ellipsis,
                            )
                          else if (width < 0)
                            AutoSizeText(
                              '$width' + sign,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.workSans().fontFamily,
                                  color: Colors.red),
                            )
                          else
                            AutoSizeText(
                              '+$width' + sign,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: GoogleFonts.workSans().fontFamily,
                                  color: Colors.white),
                            )
                        ],
                      ),
                      if (comp is Drive && comp.type == 'SSD')
                        Text(
                          'SSD',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: GoogleFonts.workSans().fontFamily,
                              color: Colors.green),
                        ),
                      if (comp is Drive && comp.type == 'HDD')
                        Text(
                          'HDD',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: GoogleFonts.workSans().fontFamily,
                              color: Colors.red),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget buildColumn(String side, List<Widget> children) {
    CrossAxisAlignment ca;
    if (side == "lewo")
      ca = CrossAxisAlignment.start;
    else
      ca = CrossAxisAlignment.end;
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: ca,
        children: children,
      ),
    );
  }

  Widget totalMem() {
    int max = 0, capacity1 = 0, capacity2 = 0;
    for (var i in Porownywarka.extradisk) {
      capacity1 += int.parse(i.capacity);
    }
    for (var i in Porownywarka.extradisk2) {
      capacity2 += int.parse(i.capacity);
    }
    capacity1 += int.parse(Porownywarka.chosenDrive.capacity);
    capacity2 += int.parse(Porownywarka.chosenDrive2.capacity);
    capacity1 > capacity2 ? max = capacity1 : max = capacity1;

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Stack(
        children: [
          Center(
            child: Container(
              
              width: MediaQuery.of(context).size.width * 0.45,
              height: 30,
              color: Color.fromRGBO(59, 55, 68, 1),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                     margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                  'Całkowita pamięć systemów',
                  style: TextStyle(color: Colors.white),
                )),
                Container(
                   
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 10,
                          height: 10,
                          color: Colors.pink,
                        ),
                        Column(
                          children: [
                            Text(
                              'Lewy zestaw',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              capacity1.toString() + ' GB',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      child: PieChart(PieChartData(
                          startDegreeOffset: 55,
                          sectionsSpace: 5,
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                                showTitle: false,
                                value: capacity1.toDouble(),
                                radius: 20,
                                color: Colors.pink,
                                titleStyle: TextStyle(color: Colors.white,fontSize: 18)),
                            PieChartSectionData(
                                showTitle: false,
                                value: capacity2.toDouble(),
                                color: Colors.lightBlue,
                                radius: 20,
                                titleStyle: TextStyle(color: Colors.white,fontSize: 18))
                          ])),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 10,
                          height: 10,
                          color: Colors.lightBlue,
                        ),
                        Column(
                          children: [
                            Text(
                              'Prawy zestaw',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              capacity2.toString() + ' GB',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Image placeholder = Image.asset('assets/placeholder.png');
    List<dynamic> build1 = [
      Porownywarka.chosenCpu,
      Porownywarka.chosenGpu,
      Porownywarka.chosenRam,
      Porownywarka.chosenPsu,
      Porownywarka.chosenDrive,
      Porownywarka.chosenMtb,
      Porownywarka.chosenCase,
      Porownywarka.chosenCooler
    ];

    List<dynamic> build2 = [
      Porownywarka.chosenCpu2,
      Porownywarka.chosenGpu2,
      Porownywarka.chosenRam2,
      Porownywarka.chosenPsu2,
      Porownywarka.chosenDrive2,
      Porownywarka.chosenMtb2,
      Porownywarka.chosenCase2,
      Porownywarka.chosenCooler2
    ];

    setScores();

    print(Porownywarka.chosenCpu.benchScore.toString() +
        Porownywarka.chosenCpu2.benchScore.toString());

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            alignment: Alignment(0, -0.8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: 1,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(142, 223, 255, 1),
                    Color.fromRGBO(255, 0, 140, 1)
                  ],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                )),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<void>(
                      future: getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done)
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        child: avatarList[avatarid1],
                                        borderRadius: BorderRadius.circular(100)),
                                    AutoSizeText(
                                      'Zestaw użytkownika \n $username ',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          fontFamily:
                                              GoogleFonts.workSans().fontFamily,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        child: avatarList[avatarid2],
                                        borderRadius: BorderRadius.circular(100)),
                                    AutoSizeText(
                                      'Zestaw użytkownika \n $username2',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          fontFamily:
                                              GoogleFonts.workSans().fontFamily,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        if (snapshot.hasError)
                          return Container();
                        else
                          return CircularProgressIndicator();
                      })),
              SizedBox(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Container(
                    child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
                )),
              ),
              Row(
                children: [
                  buildColumn('left', [
                    componentBar(
                        build1[0],
                        Image.asset('assets/companies logo/' +
                            build1[0].manufacturer.toString().toLowerCase() +
                            '.png'),
                        cpuScore1,
                        'left',
                        true,
                        'Procesor: '),
                    componentBar(
                        build1[1],
                        Image.asset('assets/companies logo/' +
                            build1[1].manufacturer.toString().toLowerCase() +
                            '.png'),
                        gpuScore1,
                        'left',
                        true,
                        'Karta graficzna: '),
                    componentBar(
                        build1[2],
                        Image.asset('assets/companies logo/' +
                            build1[2].manufacturer.toString().toLowerCase() +
                            '.png'),
                        ramScore1,
                        'left',
                        true,
                        'Ram: '),
                    componentBar(
                        build1[3],
                        Image.asset('assets/companies logo/' +
                            build1[3].manufacturer.toString().toLowerCase() +
                            '.png'),
                        psuScore1,
                        'left',
                        true,
                        'Zasilacz: '),
                    componentBar(
                        build1[4],
                        Image.asset('assets/companies logo/' +
                            build1[4].manufacturer.toString().toLowerCase() +
                            '.png'),
                        driveScore1,
                        'left',
                        true,
                        'Dysk systemowy: '),

                  ]),
                  buildColumn('right', [
                    componentBar(
                        build2[0],
                        Image.asset('assets/companies logo/' +
                            build2[0].manufacturer.toString().toLowerCase() +
                            '.png'),
                        cpuScore2,
                        'right',
                        true,
                        'Procesor: '),
                    componentBar(
                        build2[1],
                        Image.asset('assets/companies logo/' +
                            build2[1].manufacturer.toString().toLowerCase() +
                            '.png'),
                        gpuScore2,
                        'right',
                        true,
                        'Karta graficzna: '),
                    componentBar(
                        build2[2],
                        Image.asset('assets/companies logo/' +
                            build2[2].manufacturer.toString().toLowerCase() +
                            '.png'),
                        ramScore2,
                        'right',
                        true,
                        'Ram: '),
                    componentBar(
                        build2[3],
                        Image.asset('assets/companies logo/' +
                            build2[3].manufacturer.toString().toLowerCase() +
                            '.png'),
                        psuScore2,
                        'right',
                        true,
                        'Zasilacz: '),
                    componentBar(
                        build2[4],
                        Image.asset('assets/companies logo/' +
                            build2[4].manufacturer.toString().toLowerCase() +
                            '.png'),
                        driveScore2,
                        'right',
                        true,
                        'Dysk systemowy: '),
                  ])
                ],
              ),
              totalMem(),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext conctext) {
                    return AlertDialog(
                      title: Text('Jak działa porównywanie'),
                      content: Wrap(
                        children: [
                          Text(
                              'Ta strona określa szacowaną moc na postawie średnich wyników popularnych testów wydajności poszczególnych komponentów\n'),
                          Text(
                              'Dane te są szacunkowe i nie powinny decydować o ostatecznej ocenie komponentu\n\n\n\n'),
                          Text('Legenda: SM - Szacunkowa moc')
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              print('aaaaa 111');
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Zrozumiano',
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    );
                  });
            },
            child: Align(
              alignment: Alignment(1, 0.95),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Container(
                    width: 20,
                    height: 40,
                    color: Colors.white,
                    alignment: Alignment(1, 0),
                  ),
                  Container(
                      width: 50,
                      height: 40,
                      alignment: Alignment(-1, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.info,
                          color: Color.fromRGBO(59, 55, 68, 1), size: 40)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
                Porownywarka(); 
                inicjalizuj(null);
                
            },
            child: Positioned(
              left: 30.0,
              
              top: 10,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    width: 20,
                    height: 40,
                    color: Colors.white,                 
                  ),
                  Container(
                      width: 50,
                      height: 40,
                      alignment: Alignment(1, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.arrow_back,
                          color: Color.fromRGBO(59, 55, 68, 1), size: 40)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
