import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';

class viewRate extends StatefulWidget {
  final Cpu cpu;
  final Psu psu;
  final Motherboard mtb;
  final Drive drive;
  final Ram ram;
  final Case cases;
  final Gpu gpu;
  final Cooler cooler;
  final String code;

  viewRate(
      {this.cpu,
      this.psu,
      this.mtb,
      this.drive,
      this.ram,
      this.cases,
      this.gpu,
      this.cooler,
      this.code,});

  @override
  _viewRateState createState() => _viewRateState();
}

class _viewRateState extends State<viewRate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
