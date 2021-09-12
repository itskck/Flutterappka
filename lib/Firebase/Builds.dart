


import 'package:cloud_firestore/cloud_firestore.dart';

class Builds{

  final String caseId;
  final String coolerId;
  final String cpuId;
  final String driveId;
  final String generatedCode;
  final String gpuId;
  final String motherboardId;
  final String psuId;
  final String ramId;
  final Timestamp timestamp;
  final String uid;
  Builds({this.coolerId,this.caseId,this.cpuId,this.driveId,this.generatedCode,this.gpuId,this.motherboardId,this.psuId,this.ramId,this.timestamp,this.uid});
}

