import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Ram{
  final String benchScore;
  final String capacity;
  final String manufacturer;
  final String model;
  final String speed;
  final String type;
  final Image img;

  Ram({this.benchScore,this.type, this.manufacturer, this.model, this.capacity,this.speed,this.img});
}

