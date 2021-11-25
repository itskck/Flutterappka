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

  Future<void> dodajCooler(String manufacturer, String model, List<String> standard) async {
    code=await generateRandomString();
    return await coolers.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
     "socket": FieldValue.arrayUnion(standard),
    });
  }

  Future<void> dodajCpu(String benchscore,String clock,String cores,String hasGpu,String manufacturer,String model,String socket,String tdp,String threads,String year,bool isUnlocked,bool isCooler) async {
    code=await generateRandomString();
    return await cpus.doc(code).set({
      "benchscore": benchscore,
      "clock": clock,
      "cores": cores,
      "hasGpu": hasGpu,
      "isCoolerIncluded": isCooler,
      "isUnlocked": isUnlocked,
      "manufacturer": manufacturer,
      "model": model,
      "socket": socket,
      "tdp": tdp,
      "threads": threads,
      "year": year,
    });
  }

  Future<void> dodajDrive(String manufacturer,String model,String capacity,String connectionType,String type) async {
    code=await generateRandomString();
    return await drives.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "capacity": capacity,
      "connectionType": connectionType,
      "type": type,
    });
  }

  Future<void> dodajGpu(String manufacturer,String model,String Vram,bool integra,String series, String tdp, String year,String benchscore) async {
    code=await generateRandomString();
    return await gpus.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "VRAM": Vram,
      "integra": integra,
      "series": series,
      "tdp": tdp,
      "year": year,
      "benchScore": benchscore,
    });
  }

  Future<void> dodajMotherboard(String manufacturer,String model,String chipset, String ethernetSpeen,bool hasNvme,String ramSlots,String ramType,String sataPorts,String socket, String standard, String usb2,String usb3,bool wifi) async {
    code=await generateRandomString();
    return await motherboard.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "chipset": chipset,
      "ethernetSpeed": ethernetSpeen,
      "hasNvmeSlot": hasNvme,
      "ramSlots": ramSlots,
      "ramType": ramType,
      "sataPorts": sataPorts,
      "socket": socket,
      "standard": standard,
      "usb2and1": usb2,
      "usb3": usb3,
      "wifi": wifi,
    });
  }

  Future<void> dodajPsu(String manufacturer,String model,String power) async {
    code=await generateRandomString();
    return await psus.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "power": power,
    });
  }

  Future<void> dodajRam(String manufacturer,String model,String capacity, String benchScore,String speed, String type) async {
    code=await generateRandomString();
    return await rams.doc(code).set({
      "manufacturer": manufacturer,
      "model": model,
      "capacity": capacity,
      "benchScore": benchScore,
      "speed": speed,
      "type": type,
    });
  }
}