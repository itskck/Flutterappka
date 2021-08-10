import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'dart:core';

class FireBase{
  final String uid;
  FireBase({ this.uid });
  final CollectionReference gpuCollection= FirebaseFirestore.instance.collection('gpus');
  List<Gpu> gpuListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Gpu(
        VRAM: doc.data().toString().contains('VRAM') ? doc.get('VRAM') : '',
        manufacturer: doc.data().toString().contains('manufacturer') ? doc.get('manufacturer') : '',
        model: doc.data().toString().contains('model') ? doc.get('model') : '',
        year: doc.data().toString().contains('year') ? doc.get('year') : '',
        series: doc.data().toString().contains('series') ? doc.get('series') : '',
        tdp: doc.data().toString().contains('tdp') ? doc.get('tdp') : ''
      );
    }).toList();
  }
  Stream<List<Gpu>> get gpus {
    return gpuCollection.snapshots()
    .map(gpuListFromSnapshot);
  }
}