import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
class addToDatabase{
  final String uid;
  addToDatabase({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference buildCollection = FirebaseFirestore.instance.collection("builds");

  Future<void> updateUserData(String nick) async {
    return await userCollection.doc(uid).set({
      'nick': nick,
    });
  }

  Future<void> addBuildData(String nick, String cpuId, String caseId, String coolerId, String driveId, String gpuId, String motherboardId, String psuId, String ramId, String code) async{

    String pom=uid+" "+code;
    return await buildCollection.doc(pom).set({
      "nick": nick,
      "cpuId": cpuId,
      "caseId": caseId,
      "coolerId": coolerId,
      "driveId": driveId,
      "gpuId": gpuId,
      "motherboardId": motherboardId,
      "psuId": psuId,
      "ramId": ramId,
    });
  }
}