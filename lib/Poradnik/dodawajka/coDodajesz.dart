import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Poradnik/dodawajka/Case.dart';
import 'package:skladappka/Poradnik/dodawajka/Cooler.dart';
import 'package:skladappka/Poradnik/dodawajka/Cpu.dart';
import 'package:skladappka/Poradnik/dodawajka/Drive.dart';
import 'package:skladappka/Poradnik/dodawajka/Gpu.dart';
import 'package:skladappka/Poradnik/dodawajka/Motherboard.dart';
import 'package:skladappka/Poradnik/dodawajka/Psu.dart';
import 'package:skladappka/Poradnik/dodawajka/Ram.dart';
import 'package:skladappka/main.dart';

import 'package:skladappka/Poradnik/Poradnik.dart';

class coDodajesz extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Case()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Case',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Cooler()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Cooler',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Cpu()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Cpu',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Drive()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Drive',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Gpu()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Gpu',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Motherboard()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('MTB',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Psu()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Psu',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
            GestureDetector(
                onTap: () {
                  runApp(MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: appTheme(),
                      title: 'Skladapka',
                      home: Ram()));
                },
                child: Container(
                  width: 60,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(142, 223, 255, 1),
                            Color.fromRGBO(255, 0, 140, 1)
                          ])),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(45, 45, 45, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('Ram',
                        style: TextStyle(color: Colors.white,fontSize: 15),

                        textAlign: TextAlign.center,),
                    ),
                  ),
                )
            ),
          ],
        ),
        GestureDetector(
            onTap: () {
              runApp(MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: appTheme(),
                  title: 'Skladapka',
                  home: Glowna()));
            },
            child: Container(
              width: 60,
              height: 30,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(142, 223, 255, 1),
                        Color.fromRGBO(255, 0, 140, 1)
                      ])),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(45, 45, 45, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('Cofnij',
                    style: TextStyle(color: Colors.white,fontSize: 15),

                    textAlign: TextAlign.center,),
                ),
              ),
            )
        ),
      ],
    );
  }
}