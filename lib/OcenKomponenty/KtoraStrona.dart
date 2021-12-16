import 'package:flutter/material.dart';
import 'package:skladappka/OcenKomponenty/OcenKomponenty.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/OcenKomponenty/Przejscie.dart';

class whichSite extends StatelessWidget{

  final bool czyWczytuje;
  final Builds builds;

  whichSite({this.czyWczytuje,this.builds});

  @override
  Widget build(BuildContext context) {
    if(czyWczytuje==false)
      return Container(
        child: rateComponents(),
      );
    else
      return transition(builds: builds);
  }
}