import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class dodawajka{
  final CollectionReference cases =
  FirebaseFirestore.instance.collection("cases");
  final CollectionReference coolers =
  FirebaseFirestore.instance.collection("coolers");
  final CollectionReference cpus =
  FirebaseFirestore.instance.collection("cpus");
  final CollectionReference drives =
  FirebaseFirestore.instance.collection("drives");
  final CollectionReference gpus =
  FirebaseFirestore.instance.collection("gpus");
  final CollectionReference motherboard =
  FirebaseFirestore.instance.collection("motherboard");
  final CollectionReference psus =
  FirebaseFirestore.instance.collection("psus");
  final CollectionReference rams =
  FirebaseFirestore.instance.collection("rams");

  String code;
  Random _rnd = Random();
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';


  Future<String> generateRandomString() async {
    String randomString = String.fromCharCodes(List.generate(
        20, (index) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomString;
  }

  Future<void> dodajCase(String manufacturer, String model, List<String> standard) async {
   code=await generateRandomString();
    return await cases.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "standard": FieldValue.arrayUnion(standard),
    });
  }

  Future<void> dodajCooler() async {
    code=await generateRandomString();
    return await coolers.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
     // "socket": FieldValue.arrayUnion("tutaj lista jakas"),
    });
  }

  Future<void> dodajCpu() async {
    code=await generateRandomString();
    return await cpus.doc(code).set({
      "benchscore": "benchscore",
      "clock": "clock",
      "cores": "cores",
      "hasGpu": "tu jakies gpu",
      "isCoolerIncluded": "tuj jakis bool",
      "isUnlocked": "tuj jakis bool",
      "manufacturer": "manu",
      "model": "model",
      "socket": "socket",
      "tdp": "tdp",
      "threads": "threads",
      "year": "year",
    });
  }

  Future<void> dodajDrive() async {
    code=await generateRandomString();
    return await drives.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
      "capacity": "capacity",
      "connectionType": "connectionType",
      "type": "type",
    });
  }

  Future<void> dodajGpu() async {
    code=await generateRandomString();
    return await gpus.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
      "VRAM": "Vram",
      "integra": "tu jakis bool",
      "series": "series",
      "tdp": "tdp",
      "year": "year",
      "benchScore": "benchscore",
    });
  }

  Future<void> dodajMotherboard() async {
    code=await generateRandomString();
    return await motherboard.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
      "chipset": "chipset",
      "ethernetSpeed": "ethernetSpeed",
      "hasNvmeSlot": "bool",
      "ramSlots": "Ramslots",
      "ramType": "ramType",
      "sataPorts": "ramSlots",
      "socket": "socket",
      "standard": "standard",
      "usb2and1": "8",
      "usb3": "3",
      "wifi": "jakisbool",
    });
  }

  Future<void> dodajPsu() async {
    code=await generateRandomString();
    return await psus.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
      "power": "power",
    });
  }

  Future<void> dodajRam() async {
    code=await generateRandomString();
    return await rams.doc(code).set({
      "manufacturer": "manufacturer",
      "model": "model",
      "capacity": "capacity",
      "benchScore": "benchScore",
      "speed": "speed",
      "type": "type",
    });
  }
}