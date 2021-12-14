import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'dart:core';
import 'package:skladappka/Firebase/PobierzBazeDanych/PobierzZapisany.dart';
import 'package:skladappka/Cache.dart' as globalna;
import 'package:skladappka/wczytajZestaw/Wybor.dart';
import 'package:skladappka/OcenKomponenty/OcenKomponenty.dart';

import 'package:skladappka/Porownywarka/Porownywarka.dart';

class dialogBuilderForCompare extends StatelessWidget {
  var builds;
  int ktoro;
  dialogBuilderForCompare({this.ktoro});
  @override
  Widget build(BuildContext context) {
    builds = Provider.of<List<Builds>>(context) ?? [];
    return SimpleDialog(
        title: Text(
          'Wybierz swój zestaw',
          style: TextStyle(
              fontFamily: GoogleFonts.workSans().fontFamily, fontSize: 20),
        ),
        children: [
          for (int i = 0; i < builds.length; i++)
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zestaw z ' + builds[i].timestamp.substring(0, 10),
                        style: TextStyle(
                            fontFamily: GoogleFonts.workSans().fontFamily,
                            fontSize: 18),
                      ),
                      Text('Kod: '+builds[i].generatedCode,style: TextStyle(
                            fontFamily: GoogleFonts.workSans().fontFamily,
                            fontSize: 18),)
                    ],
                  ),
                  Text(builds[i].cpuId +", "+builds[i].gpuId+', '+builds[i].motherboardId,
                  maxLines: 1
                  ,style: TextStyle(fontSize: 12),),
                  Text('i 5 innych...',style: TextStyle(fontSize: 12),)
                ],
              ),
              onPressed: () async {
                if (ktoro == 0) if (globalna.ktoro == 3) {
                  Porownywarka.chosenCpu =
                      await getFromSaved(id: builds[i].cpuId).getCpu();
                  Porownywarka.chosenPsu =
                      await getFromSaved(id: builds[i].psuId).getPsu();
                  Porownywarka.chosenMtb =
                      await getFromSaved(id: builds[i].motherboardId)
                          .getMotherboard();
                  Porownywarka.chosenDrive =
                      await getFromSaved(id: builds[i].driveId).getDrive();
                  Porownywarka.chosenRam =
                      await getFromSaved(id: builds[i].ramId).getRam();
                  Porownywarka.chosenCase =
                      await getFromSaved(id: builds[i].caseId).getCase();
                  Porownywarka.chosenGpu =
                      await getFromSaved(id: builds[i].gpuId).getGpu();
                  Porownywarka.chosenCooler =
                      await getFromSaved(id: builds[i].coolerId).getCooler();
                  Porownywarka.uid = builds[i].uid;
                  Porownywarka.extradisk =
                      await getFromSaved(builds: builds[i]).setExtra();
                } else if (globalna.ktoro == 1) {
                  choices.builds = builds[i];
                } else
                  rateComponents.builds = builds[i];
                else {
                  Porownywarka.chosenCpu2 =
                      await getFromSaved(id: builds[i].cpuId).getCpu();
                  Porownywarka.chosenPsu2 =
                      await getFromSaved(id: builds[i].psuId).getPsu();
                  Porownywarka.chosenMtb2 =
                      await getFromSaved(id: builds[i].motherboardId)
                          .getMotherboard();
                  Porownywarka.chosenDrive2 =
                      await getFromSaved(id: builds[i].driveId).getDrive();
                  Porownywarka.chosenRam2 =
                      await getFromSaved(id: builds[i].ramId).getRam();
                  Porownywarka.chosenCase2 =
                      await getFromSaved(id: builds[i].caseId).getCase();
                  Porownywarka.chosenGpu2 =
                      await getFromSaved(id: builds[i].gpuId).getGpu();
                  Porownywarka.chosenCooler2 =
                      await getFromSaved(id: builds[i].coolerId).getCooler();
                  Porownywarka.uid2 = builds[i].uid;
                  Porownywarka.extradisk2 =
                      await getFromSaved(builds: builds[i]).setExtra();
                }
                Navigator.pop(context);
              },
            )
        ]);
  }
}
