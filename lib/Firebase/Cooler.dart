import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoolerList extends StatefulWidget{
  @override
  _CoolerListState createState() => _CoolerListState();
}
class _CoolerListState extends State<CoolerList>{
  @override
  Widget build(BuildContext context) {
    final coolers = Provider.of<List<Cooler>>(context)??[];
    return ListView.builder(
      itemCount: coolers.length,
      itemBuilder: (context, index) {
        return CoolerTile(cooler: coolers[index]);
      },
    );
  }
}

class Cooler{

  final String socket;
  final String manufacturer;
  final String model;
  Cooler({this.manufacturer, this.model, this.socket});
}

class CoolerTile extends StatelessWidget{
  final Cooler cooler;
  CoolerTile({this.cooler});
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
          title: Text(cooler.manufacturer),
          subtitle: Text(cooler.model),
        ),
      ),
    );
  }
}