import 'package:firebase_auth/firebase_auth.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'Edytuj.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Firebase/PobierzBazeDanych/PobierzZapisany.dart';

class transition extends StatelessWidget {

  final Builds builds;
  transition({this.builds});

   Cpu chosenCpu;
   Psu chosenPsu;
   Motherboard chosenMtb;
   Drive chosenDrive;
   Ram chosenRam;
   Case chosenCase;
   Gpu chosenGpu;
   Cooler chosenCooler;
   List<Drive> extradisk;


  Future<Cpu> setCpu() async{
    Cpu cpu = await getFromSaved(id: builds.cpuId).getCpu();
    return cpu;
  }

  Future<Gpu> setGpu() async{
    Gpu gpu = await getFromSaved(id: builds.gpuId).getGpu();
    return gpu;
  }

  Future<Psu> setPsu() async{
    Psu psu= await getFromSaved(id: builds.psuId).getPsu();
    return psu;
  }

  Future<Motherboard> setMtb() async{
    Motherboard mtb= await getFromSaved(id: builds.motherboardId).getMotherboard();
    return mtb;
  }

  Future<Drive> setDrive() async{
    Drive drive= await getFromSaved(id: builds.driveId).getDrive();
    return drive;
  }

  Future<Ram> setRam() async{
    Ram ram= await getFromSaved(id: builds.ramId).getRam();
    return ram;
  }

  Future<Case> setCase() async{
    Case cases= await getFromSaved(id: builds.caseId).getCase();
    return cases;
  }

  Future<Cooler> setCooler() async{
    
    Cooler cooler= await getFromSaved(id: builds.coolerId).getCooler();
    return cooler;
  }
  Future<List<Drive>> setExtra() async{

    extradisk = new List<Drive>();
    String number="", disk="";
    int space=0, numberint;
    if(builds.extradisk[0]=="Brak"){
      return extradisk;
    }
    for(int i=0; i<builds.extradisk.length;i++){
      while(builds.extradisk[i][space]!=" "){
        print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
        print(builds.extradisk[i][space]);
        number+=builds.extradisk[i][space];
        space++;
      }
      space++;
      print("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
      print(builds.extradisk[i][space]);
      for(;space<builds.extradisk[i].length;space++)
        disk+=builds.extradisk[i][space];
      space=0;
      numberint=int.parse(number);
      number="";
      for(int j=0;j<numberint;j++){
        extradisk.add(await getFromSaved(id: disk).getDrive());
      }
      disk="";
    }
   // print("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
    //print(extradisk.length);
    return extradisk;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cpu>(
      future: setCpu(),
      builder: (context, cpu){
        if (cpu.connectionState == ConnectionState.done){
          print(cpu.data.model);
          chosenCpu=cpu.data;
          return FutureBuilder<Gpu>(
              future: setGpu(),
              builder: (context, gpu){
                if (gpu.connectionState == ConnectionState.done){
                  chosenGpu=gpu.data;
                  return FutureBuilder<Psu>(
                    future: setPsu(),
                      builder: (context, psu){
                        if (psu.connectionState == ConnectionState.done){
                          chosenPsu=psu.data;
                          return FutureBuilder<Motherboard>(
                              future: setMtb(),
                              builder: (context, mtb){
                                if (mtb.connectionState == ConnectionState.done){
                                  chosenMtb=mtb.data;
                                  return FutureBuilder<Drive>(
                                      future: setDrive(),
                                      builder: (context, drive){
                                        if (drive.connectionState == ConnectionState.done){
                                          chosenDrive=drive.data;
                                          return FutureBuilder<Ram>(
                                              future: setRam(),
                                              builder: (context, ram){
                                                if (ram.connectionState == ConnectionState.done){
                                                  chosenRam=ram.data;
                                                  return FutureBuilder<Case>(
                                                      future: setCase(),
                                                      builder: (context, cases){
                                                        if (cases.connectionState == ConnectionState.done){
                                                          chosenCase=cases.data;
                                                          return FutureBuilder<Cooler>(
                                                              future: setCooler(),
                                                              builder: (context, cooler){
                                                                if (cooler.connectionState == ConnectionState.done){
                                                                  chosenCooler=cooler.data;
                                                                  return FutureBuilder<List<Drive>>(
                                                                    future: setExtra(),
                                                                    builder: (context, extradisks){
                                                                      if(extradisks.connectionState==ConnectionState.done){
                                                                        extradisk=extradisks.data;
                                                                        print("youiuop");
                                                                        print(extradisks.data.length);
                                                                        if(builds.uid!=FirebaseAuth.instance.currentUser.uid)
                                                                          return Edit(cpu: chosenCpu, cases: chosenCase, cooler: chosenCooler, drive: chosenDrive,
                                                                              gpu: chosenGpu, mtb: chosenMtb, psu: chosenPsu, ram: chosenRam, code: builds.generatedCode, diffUser: true,
                                                                              minTdp: builds.minTdp.toDouble(), maxTdp: builds.maxTdp.toDouble(),extradisk: extradisk, ramNumber: builds.ramNumber);
                                                                        else
                                                                          return Edit(cpu: chosenCpu, cases: chosenCase, cooler: chosenCooler, drive: chosenDrive,
                                                                              gpu: chosenGpu, mtb: chosenMtb, psu: chosenPsu, ram: chosenRam, code: builds.generatedCode, diffUser: false,
                                                                              minTdp: builds.minTdp.toDouble(), maxTdp: builds.maxTdp.toDouble(),extradisk: extradisk,ramNumber: builds.ramNumber);
                                                                      }
                                                                      else return Container();
                                                                    },
                                                                  );
                                                                }
                                                                else return Container();
                                                              },
                                                          );
                                                        }
                                                        else return Container();
                                                      },
                                                  );
                                                }
                                                else return Container();
                                              },
                                          );
                                        }
                                        else return Container();
                                      },
                                  );
                                }
                                else return Container();
                              },
                          );
                        }
                        else return Container();
                      },
                  );
                }
                else return Container();
              },
          );
        }
        else return Center(child: CircularProgressIndicator(
          color: Colors.white,
        ));

      },
    );
  }
}