import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriveList extends StatefulWidget{
  @override
  _DriveListState createState() => _DriveListState();
}
class _DriveListState extends State<DriveList>{
  @override
  Widget build(BuildContext context) {
    final drives = Provider.of<List<Drive>>(context)??[];
    return ListView.builder(
      itemCount: drives.length,
      itemBuilder: (context, index) {
        return DriveTile(drive: drives[index]);
      },
    );
  }
}

class Drive{

  final String capacity;
  final String connectionType;
  final String type;
  Drive({this.capacity,this.connectionType,this.type});
}

class DriveTile extends StatelessWidget{
  final Drive drive;
  DriveTile({this.drive});
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
          title: Text(drive.connectionType),
          subtitle: Text(drive.type),
        ),
      ),
    );
  }
}