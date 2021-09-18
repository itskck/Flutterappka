import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'Porownywarka.dart';
import 'package:auto_size_text/auto_size_text.dart';
class Comparison extends StatefulWidget {
  const Comparison({Key key}) : super(key: key);

  @override
  _Comparison createState() => _Comparison();
}

class _Comparison extends State<Comparison> {
   var cpuScore1,cpuScore2,gpuScore1,gpuScore2,ramScore1,ramScore2,driveScore1,driveScore2,psuScore1,psuScore2;
  List<dynamic> build1 = [
    Porownywarka.chosenCpu,
    Porownywarka.chosenGpu,
    Porownywarka.chosenRam,
    Porownywarka.chosenPsu,
    Porownywarka.chosenDrive,
    Porownywarka.chosenMtb,   
    Porownywarka.chosenCase,    
    Porownywarka.chosenCooler
  ];

  List<dynamic> build2=[
   Porownywarka.chosenCpu2,
    Porownywarka.chosenGpu2,
    Porownywarka.chosenRam2,
    Porownywarka.chosenPsu2,
    Porownywarka.chosenDrive2,
    Porownywarka.chosenMtb2,   
    Porownywarka.chosenCase2,    
    Porownywarka.chosenCooler2
  ];

  double bigger(double a, double b){
    if(a>b) return a;
    if(b>a) return b;
    else return 0;
  }
  double lower(double a,double b){
    if(a>b) return b;
    if(b>a) return a;
    else return 1;  
  }

  void setScores(){
    if(build1[0]>build2[0]){
      
    }
  }
  Widget componentBar(String component,Image placeholder,double width,String side,bool isThere) {
    TextDirection td;
    Alignment al;
    CrossAxisAlignment crossAxisAlignment;
    width=double.parse(width.toStringAsFixed(1));
    
    var pixelWidth =width;
    if(pixelWidth>100)pixelWidth=100;
    if(side=='left') {
      td=TextDirection.ltr;
      al=Alignment.centerLeft;
      crossAxisAlignment=CrossAxisAlignment.start;
      }
    else{
      td=TextDirection.rtl;
      al=Alignment.centerRight;
      crossAxisAlignment=CrossAxisAlignment.end;
      }


    if(isThere==false) return Container(
      width: MediaQuery.of(context).size.width /2,
      height: 60,

    );
    else
    return Container(
      width: MediaQuery.of(context).size.width /2,
      height: 70,
      child: Row(
        textDirection: td,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: placeholder),
          LimitedBox(
            maxWidth: MediaQuery.of(context).size.width/2 -40,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                AutoSizeText(component,  
                    
                maxLines: 1,
                overflow: TextOverflow.clip,
          
                ),
                Row(
                  textDirection: td,
                  children: [
                    Container(
                      alignment: al,
                      child: SizedBox(              
                        
                        width: pixelWidth,
                        height: 5 ,
                        child: Container(
                          
                          color: Colors.green,
                        ),
                      ),
                    ),
                    if(width!=0)
                    Text(
                      '+$width%',
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
          ),
           
               
             
          
          
        ],
      ),
    );
  }

  Widget buildColumn(String side, List<Widget> children) {

    CrossAxisAlignment ca;
    if (side == "lewo")
      ca = CrossAxisAlignment.start;
    else
      ca = CrossAxisAlignment.end;
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: ca,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    Image placeholder = Image.asset('assets/placeholder.png');
    
   
    

    return Row(
      children: [
      buildColumn('left', [
        componentBar(build1[0].model, placeholder, cpuScore1, 'left', true),
        componentBar(build1[1].model, placeholder, gpuScore1, 'left', true),
        componentBar(build1[2].model, placeholder, ramScore1, 'left', true),
        componentBar(build1[3].model, placeholder, psuScore1, 'left', true),
        componentBar(build1[4].model, placeholder, driveScore1, 'left', true),
        componentBar(build1[5].model, placeholder, 0, 'left', true),
        componentBar(build1[6].model, placeholder, 0, 'left', true),
        componentBar(build1[7]!=null?build1[7].model:"nope", placeholder, 0, 'left', build1[7]!=null? true:false),
        

      ]),
      
      buildColumn('right', [
        componentBar(build2[0].model, placeholder, cpuScore2, 'right', true),
        componentBar(build2[1].model, placeholder, gpuScore2, 'right', true),
        componentBar(build2[2].model, placeholder, ramScore2, 'right', true),
        componentBar(build2[3].model, placeholder, psuScore2, 'right', true),
        componentBar(build2[4].model, placeholder, driveScore2, 'right', true),
        componentBar(build2[5].model, placeholder, 0, 'right', true),
        componentBar(build2[6].model, placeholder, 0, 'right', true),
        componentBar(build2[7]!=null?build2[7].model:"nope", placeholder, 0, 'right', build2[7]!=null? true:false),
      ])],
    );
  }
}
