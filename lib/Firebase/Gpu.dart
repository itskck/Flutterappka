import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Gpu{
  final String benchScore;
  final String VRAM;
  final String manufacturer;
  final String model;
  final String year;
  final String series;
  final String tdp;
  final bool integra;
  final Image img;
  Gpu({this.benchScore,this.tdp, this.manufacturer, this.model, this.year,this.series,this.VRAM,this.integra,this.img});
}

