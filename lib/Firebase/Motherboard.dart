import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Motherboard{

  final String chipset;
  final String manufacturer;
  final String model;
  final String ramSlots;
  final String ramType;
  final String socket;
  final String standard;
  final bool hasNvmeSlot;
  final Image img;

  Motherboard({this.model,this.standard,this.manufacturer,this.chipset,this.hasNvmeSlot,this.ramSlots,this.ramType,this.socket,this.img});
}

