import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Cpu{
  final String benchScore;
  final String socket;
  final String manufacturer;
  final String model;
  final String year;
  final String tdp;
  final String clocker;
  final String cores;
  final bool hasGpu;
  final bool isCoolerIncluded;
  final bool isUnlocked;
  final String threads;
  Cpu({this.benchScore,this.socket, this.manufacturer, this.model, this.year,this.tdp,this.clocker,this.cores,this.hasGpu,this.isCoolerIncluded,this.isUnlocked,this.threads});
}

