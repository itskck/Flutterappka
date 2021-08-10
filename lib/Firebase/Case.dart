import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaseList extends StatefulWidget{
  @override
  _CaseListState createState() => _CaseListState();
}
class _CaseListState extends State<CaseList>{
  @override
  Widget build(BuildContext context) {
    final cases = Provider.of<List<Case>>(context)??[];
    return ListView.builder(
      itemCount: cases.length,
      itemBuilder: (context, index) {
        return CaseTile(caser: cases[index]);
      },
    );
  }
}

class Case{

  final String standard;
  final String manufacturer;
  final String model;
  Case({this.manufacturer, this.model, this.standard});
}

class CaseTile extends StatelessWidget{
  final Case caser;
  CaseTile({this.caser});
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
          title: Text(caser.manufacturer),
          subtitle: Text(caser.standard),
        ),
      ),
    );
  }
}