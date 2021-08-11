import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CpuList extends StatefulWidget{
  @override
  _CpuListState createState() => _CpuListState();
}
class _CpuListState extends State<CpuList>{
  @override
  Widget build(BuildContext context) {
    final cpus = Provider.of<List<Cpu>>(context)??[];
    return ListView.builder(
      itemCount: cpus.length,
      itemBuilder: (context, index) {
        return CpuTile(cpu: cpus[index]);
      },
    );
  }
}

class Cpu{

  final String socket;
  final String manufacturer;
  final String model;
  final String year;
  final String tdp;
  final String clocker;
  final String cores;
  final bool hasGpu;
  final bool isCoolerIncluded;
  final bool isUnlocked;
  final String threads;
  Cpu({this.socket, this.manufacturer, this.model, this.year,this.tdp,this.clocker,this.cores,this.hasGpu,this.isCoolerIncluded,this.isUnlocked,this.threads});
}

class CpuTile extends StatelessWidget{
  final Cpu cpu;
  CpuTile({this.cpu});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
          ),
          title: Text(cpu.manufacturer),
          subtitle: Text(cpu.cores),
        ),
      ),
    );
  }
}