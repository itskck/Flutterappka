import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MotherboardList extends StatefulWidget{
  @override
  _MotherboardListState createState() => _MotherboardListState();
}
class _MotherboardListState extends State<MotherboardList>{
  @override
  Widget build(BuildContext context) {
    final motherboards = Provider.of<List<Motherboard>>(context)??[];
    return ListView.builder(
      itemCount: motherboards.length,
      itemBuilder: (context, index) {
        return MotherboardTile(motherboard: motherboards[index]);
      },
    );
  }
}

class Motherboard{

  final String chipset;
  final String manufacturer;
  final String model;
  final String ramSlots;
  final String ramType;
  final String socket;
  final String standard;
  final bool hasNvmeSlot;

  Motherboard({this.model,this.standard,this.manufacturer,this.chipset,this.hasNvmeSlot,this.ramSlots,this.ramType,this.socket});
}

class MotherboardTile extends StatelessWidget{
  final Motherboard motherboard;
  MotherboardTile({this.motherboard});
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
          title: Text(motherboard.manufacturer),
          subtitle: Text(motherboard.ramType),
        ),
      ),
    );
  }
}