import 'package:skladappka/Firebase/Builds.dart';
import 'package:flutter/material.dart';


class listGenerator extends StatelessWidget{
  final Builds builds;
  listGenerator({this.builds});
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
           title: Text(builds.uid),
         ),
      ),
    );
  }
}
