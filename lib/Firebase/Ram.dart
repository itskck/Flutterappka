import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RamList extends StatefulWidget{
  @override
  _RamListState createState() => _RamListState();
}
class _RamListState extends State<RamList>{
  @override
  Widget build(BuildContext context) {
    final rams = Provider.of<List<Ram>>(context)??[];
    return ListView.builder(
      itemCount: rams.length,
      itemBuilder: (context, index) {
        return RamTile(ram: rams[index]);
      },
    );
  }
}

class Ram{

  final String capacity;
  final String manufacturer;
  final String model;
  final String speed;
  final String type;

  Ram({this.type, this.manufacturer, this.model, this.capacity,this.speed});
}

class RamTile extends StatelessWidget{
  final Ram ram;
  RamTile({this.ram});
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
          title: Text(ram.manufacturer),
          subtitle: Text(ram.speed),
        ),
      ),
    );
  }
}