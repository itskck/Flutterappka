import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Case{

  final List<dynamic> standard;
  final String manufacturer;
  final String model;
  final Image img;
  Case({this.manufacturer, this.model, this.standard,this.img});
}

