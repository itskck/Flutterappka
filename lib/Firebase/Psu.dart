import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PsuList extends StatefulWidget{
  @override
  _PsuListState createState() => _PsuListState();
}
class _PsuListState extends State<PsuList>{
  @override
  Widget build(BuildContext context) {
    final psus = Provider.of<List<Psu>>(context)??[];
    return ListView.builder(
      itemCount: psus.length,
      itemBuilder: (context, index) {
        return PsuTile(psu: psus[index]);
      },
    );
  }
}

class Psu{

  final String power;
  final String manufacturer;
  final String model;

  Psu({this.power, this.manufacturer, this.model});
}

class PsuTile extends StatelessWidget{
  final Psu psu;
  PsuTile({this.psu});
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
          title: Text(psu.manufacturer),
          subtitle: Text(psu.power),
        ),
      ),
    );
  }
}