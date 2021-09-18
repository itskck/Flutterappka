import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GpuList extends StatefulWidget{
  @override
  _GpuListState createState() => _GpuListState();
}
class _GpuListState extends State<GpuList>{
  @override
  Widget build(BuildContext context) {
    final gpus = Provider.of<List<Gpu>>(context)??[];
    return ListView.builder(
      itemCount: gpus.length,
      itemBuilder: (context, index) {
        return GpuTile(gpu: gpus[index]);
      },
    );
  }
}

class Gpu{
  final String benchScore;
  final String VRAM;
  final String manufacturer;
  final String model;
  final String year;
  final String series;
  final String tdp;
  Gpu({this.benchScore,this.tdp, this.manufacturer, this.model, this.year,this.series,this.VRAM});
}

class GpuTile extends StatelessWidget{
  final Gpu gpu;
  GpuTile({this.gpu});
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
          title: Text(gpu.manufacturer),
          subtitle: Text(gpu.VRAM),
        ),
      ),
    );
  }
}