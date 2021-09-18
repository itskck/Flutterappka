import 'package:flutter/material.dart';
import 'Porownywarka.dart';

class Comparison extends StatefulWidget {
  const Comparison({Key key}) : super(key: key);

  @override
  _Comparison createState() => _Comparison();
}

class _Comparison extends State<Comparison> {
  List<dynamic> build1 = [
    Porownywarka.chosenCpu,
    Porownywarka.chosenPsu,
    Porownywarka.chosenMtb,
    Porownywarka.chosenDrive,
    Porownywarka.chosenRam,
    Porownywarka.chosenCase,
    Porownywarka.chosenGpu,
    Porownywarka.chosenCooler
  ];

  List<dynamic> build2=[
    Porownywarka.chosenCpu2,
    Porownywarka.chosenPsu2,
    Porownywarka.chosenMtb2,
    Porownywarka.chosenDrive2,
    Porownywarka.chosenRam2,
    Porownywarka.chosenCase2,
    Porownywarka.chosenGpu2,
    Porownywarka.chosenCooler2
  ];

  List<int>scores = [

  ];

  Widget componentBar(String component) {}

  Widget buildColumn(String side, List<Widget> children) {
    CrossAxisAlignment ca;
    if (side == "lewo")
      ca = CrossAxisAlignment.start;
    else
      ca = CrossAxisAlignment.end;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: ca,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Column()],
    );
  }
}
