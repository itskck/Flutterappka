import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/dodawanieZestawu/dodaj.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/getFromDatabase/getFromSaved.dart';

class transition extends StatelessWidget {

  final Builds builds;
  Cpu cpu;
  Case cases;
  Cooler cooler;
  Drive drive;
  Gpu gpu;
  Motherboard mtb;
  Psu psu;
  Ram ram;
  transition({this.builds});

  Future<void> setComp() async{
    cpu = await getFromSaved(id: builds.cpuId).getCpu();
    psu = await getFromSaved(id: builds.psuId).getPsu();
    mtb = await getFromSaved(id: builds.motherboardId).getMotherboard();
    drive = await getFromSaved(id: builds.driveId).getDrive();
    ram = await getFromSaved(id: builds.ramId).getRam();
    cases = await getFromSaved(id: builds.caseId).getCase();
    gpu = await getFromSaved(id: builds.gpuId).getGpu();
    cooler = await getFromSaved(id: builds.coolerId).getCooler();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: setComp(),
      builder: (context, snapshot){
        return dodaj(cpu: cpu, cases: cases, cooler: cooler, drive: drive, gpu: gpu, mtb: mtb, psu: psu, ram: ram, code: builds.generatedCode);
      },
    );
  }
}
