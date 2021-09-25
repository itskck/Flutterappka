import 'package:flutter/material.dart';
import 'package:skladappka/wczytajZestaw/choices.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/wczytajZestaw/transition.dart';

class wczytajZestaw extends StatelessWidget{    
  
  final bool czyWczytuje;
  final Builds builds;

  wczytajZestaw({this.czyWczytuje,this.builds});

  @override
  Widget build(BuildContext context) {
    print("galo");
    if(czyWczytuje==false)
      return Container(
       child: choices(),
     );
    else
      return transition(builds: builds);
  }
}