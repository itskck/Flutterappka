import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:skladappka/Firebase/Case.dart';
import 'package:skladappka/Firebase/Cooler.dart';
import 'package:skladappka/Firebase/Cpu.dart';
import 'package:skladappka/Firebase/Drive.dart';
import 'package:skladappka/Firebase/Gpu.dart';
import 'package:skladappka/Firebase/Motherboard.dart';
import 'package:skladappka/Firebase/Psu.dart';
import 'package:skladappka/Firebase/Ram.dart';

class viewRate extends StatefulWidget {
  final Cpu cpu;
  final Psu psu;
  final Motherboard mtb;
  final Drive drive;
  final Ram ram;
  final Case cases;
  final Gpu gpu;
  final Cooler cooler;
  final String code;

  viewRate(
      {this.cpu,
      this.psu,
      this.mtb,
      this.drive,
      this.ram,
      this.cases,
      this.gpu,
      this.cooler,
      this.code,});

  @override
  _viewRateState createState() => _viewRateState();
}

class _viewRateState extends State<viewRate> {
  Widget buildItems() {
    List<String> compList=[
      widget.cpu.model,
      widget.gpu.model,
      widget.ram.model,
      widget.psu.model,
      widget.drive.model,
      widget.mtb.model,
      widget.cases.model,
    ];
    List<String> typeList=[
      'Procesor: ',
      'Karta graficzna: ',
      'Ram: ',
      'Zasilacz: ',
      'Dysk systemowy: ',
      'Płyta główna: ',
      'Obudowa: ',
    ];
    
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Column(
        children: [
          SizedBox(height: 60,),
          Text('Twój zestaw:',
          style: TextStyle(
            fontFamily: GoogleFonts.workSans().fontFamily,
            color: Colors.white,
            fontSize: 25
          ),),
          for(int i=0;i<compList.length;i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          Text(typeList[i],
          style: TextStyle(
            fontFamily: GoogleFonts.workSans().fontFamily,
            color: Colors.white,
            fontSize: 15
          ),),
          GradientText(compList[i]+" ", 
          colors: [
            Color.fromRGBO(142, 223, 255, 1),
                Color.fromRGBO(142, 223, 255, 1),               
          ],       
          style: TextStyle(
            
            fontFamily: GoogleFonts.workSans().fontFamily,
            
            
            fontSize: 18
          ),), ]
          ),
          SizedBox(height: 100,),

          Text('final text')
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(children: [
          buildItems()
        ],),
      ),
    );
  }
}
