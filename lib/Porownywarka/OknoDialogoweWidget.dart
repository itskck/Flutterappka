import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'dart:core';
import 'OknoDialogoweBuilder.dart';

class dialogWidgetForCompare {

  Future<void> showPopup(BuildContext context, int ktoro) async {
    await showDialog(
        context: context,
        builder: (BuildContext c) => popupWindow(c, ktoro));
  }

  Widget popupWindow(BuildContext context, int ktoro) {
    //Stream z buildami użytkownika
    return StreamProvider<List<Builds>>.value(
      value: FireBase().builds,
      initialData: [],
      child: dialogBuilderForCompare(ktoro: ktoro),
    );
  }
}
