import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/dodawanieZestawu/dodaj.dart';
import 'Porownywarka.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

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
    print('start');
    var cpu;
    if(num.parse(Porownywarka.chosenCpu.benchScore)>num.parse(Porownywarka.chosenCpu2.benchScore))
    cpu = num.parse(Porownywarka.chosenCpu.benchScore) /
        num.parse(Porownywarka.chosenCpu2.benchScore) *
        100;
    else
      cpu = num.parse(Porownywarka.chosenCpu2.benchScore) /
          num.parse(Porownywarka.chosenCpu.benchScore) *
          100;
    print(cpu);
    cpuScore1 = cpu;
    cpuScore2 = (-1) * cpu;
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
    if(num.parse(Porownywarka.chosenGpu.benchScore)>num.parse(Porownywarka.chosenGpu2.benchScore))
    gpu = (num.parse(Porownywarka.chosenGpu.benchScore) /
        num.parse(Porownywarka.chosenGpu2.benchScore)) *
        100;
    else
      gpu = (num.parse(Porownywarka.chosenGpu2.benchScore) /
          num.parse(Porownywarka.chosenGpu.benchScore)) *
          100;
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
    if(num.parse(Porownywarka.chosenRam.benchScore)>num.parse(Porownywarka.chosenRam2.benchScore))
    ram = num.parse(Porownywarka.chosenRam.benchScore) /
        num.parse(Porownywarka.chosenRam2.benchScore) *
        100;
    else
      ram = num.parse(Porownywarka.chosenRam2.benchScore) /
          num.parse(Porownywarka.chosenRam.benchScore) *
          100;
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
    if(num.parse(Porownywarka.chosenPsu.power)>num.parse(Porownywarka.chosenPsu2.power))
    psu = num.parse(Porownywarka.chosenPsu.power) /
        num.parse(Porownywarka.chosenPsu2.power) *
        100;
    else
      psu = num.parse(Porownywarka.chosenPsu2.power) /
          num.parse(Porownywarka.chosenPsu.power) *
          100;
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
    if(num.parse(Porownywarka.chosenDrive.capacity)>num.parse(Porownywarka.chosenDrive2.capacity))
    drive = num.parse(Porownywarka.chosenDrive.capacity).toDouble() -
        num.parse(Porownywarka.chosenDrive2.capacity).toDouble();
    else
      drive = num.parse(Porownywarka.chosenDrive2.capacity).toDouble() -
          num.parse(Porownywarka.chosenDrive.capacity).toDouble();

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
      String side, bool isThere) {
    TextDirection td;
    String component = comp.model;

    Alignment al;
    CrossAxisAlignment crossAxisAlignment;
    double width = dp(t_width, 1);
    String sign;

    if (comp is Drive && isInTBs == false)
      sign = ' GB';
    else if (comp is Drive && isInTBs == true)
      sign = ' TB';
    else
      sign = '%';
    var pixelWidth = width;
    if (pixelWidth < 0) pixelWidth = pixelWidth * (-1);
    if (pixelWidth > 50) pixelWidth = 50;
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
        width: MediaQuery.of(context).size.width *0.5-1,
        height: 70,
        child: Row(
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
              maxWidth: MediaQuery.of(context).size.width *0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  AutoSizeText(
                    component.length > 15
                        ? " " +
                            component.substring(
                                0, component.length - component.length + 15) +
                            "..."
                        : " " + component,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
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
                ],
              ),
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

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
                      true),
                  componentBar(
                      build1[1],
                      Image.asset('assets/companies logo/' +
                          build1[1].manufacturer.toString().toLowerCase() +
                          '.png'),
                      gpuScore1,
                      'left',
                      true),
                  componentBar(
                      build1[2],
                      Image.asset('assets/companies logo/' +
                          build1[2].manufacturer.toString().toLowerCase() +
                          '.png'),
                      ramScore1,
                      'left',
                      true),
                  componentBar(
                      build1[3],
                      Image.asset('assets/companies logo/' +
                          build1[3].manufacturer.toString().toLowerCase() +
                          '.png'),
                      psuScore1,
                      'left',
                      true),
                  componentBar(
                      build1[4],
                      Image.asset('assets/companies logo/' +
                          build1[4].manufacturer.toString().toLowerCase() +
                          '.png'),
                      driveScore1,
                      'left',
                      true),
                  componentBar(
                      build1[5],
                      Image.asset('assets/companies logo/' +
                          build1[5].manufacturer.toString().toLowerCase() +
                          '.png'),
                      0,
                      'left',
                      true),
                  componentBar(
                      build1[6],
                      Image.asset('assets/companies logo/' +
                          build1[6].manufacturer.toString().toLowerCase() +
                          '.png'),
                      0,
                      'left',
                      true),
                  componentBar(
                      build1[7],
                      build1[7].manufacturer != 'placeholder'
                          ? Image.asset('assets/companies logo/' +
                              build1[7].manufacturer.toString().toLowerCase() +
                              '.png')
                          : Image.asset('assets/companies logo/' +
                              build1[0].manufacturer.toString().toLowerCase() +
                              '.png'),
                      0,
                      'left',
                      build1[7] != null ? true : false),
                ]),
                buildColumn('right', [
                  componentBar(
                      build2[0],
                      Image.asset('assets/companies logo/' +
                          build2[0].manufacturer.toString().toLowerCase() +
                          '.png'),
                      cpuScore2,
                      'right',
                      true),
                  componentBar(
                      build2[1],
                      Image.asset('assets/companies logo/' +
                          build2[1].manufacturer.toString().toLowerCase() +
                          '.png'),
                      gpuScore2,
                      'right',
                      true),
                  componentBar(
                      build2[2],
                      Image.asset('assets/companies logo/' +
                          build2[2].manufacturer.toString().toLowerCase() +
                          '.png'),
                      ramScore2,
                      'right',
                      true),
                  componentBar(
                      build2[3],
                      Image.asset('assets/companies logo/' +
                          build2[3].manufacturer.toString().toLowerCase() +
                          '.png'),
                      psuScore2,
                      'right',
                      true),
                  componentBar(
                      build2[4],
                      Image.asset('assets/companies logo/' +
                          build2[4].manufacturer.toString().toLowerCase() +
                          '.png'),
                      driveScore2,
                      'right',
                      true),
                  componentBar(
                      build2[5],
                      Image.asset('assets/companies logo/' +
                          build2[5].manufacturer.toString().toLowerCase() +
                          '.png'),
                      0,
                      'right',
                      true),
                  componentBar(
                      build2[6],
                      Image.asset('assets/companies logo/' +
                          build2[6].manufacturer.toString().toLowerCase() +
                          '.png'),
                      0,
                      'right',
                      true),
                  componentBar(
                      build2[7],
                      build2[7].manufacturer != 'placeholder'
                          ? Image.asset('assets/companies logo/' +
                              build2[7].manufacturer.toString().toLowerCase() +
                              '.png')
                          : Image.asset('assets/companies logo/' +
                              build2[0].manufacturer.toString().toLowerCase() +
                              '.png'),
                      0,
                      'right',
                      build2[7] != null ? true : false),
                ])
              ],
            ),
          ],
        ),
      ],
    );
  }
}
