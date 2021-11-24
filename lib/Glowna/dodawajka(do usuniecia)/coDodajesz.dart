import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skladappka/Glowna/dodawajka(do usuniecia)/Case.dart';
import 'package:skladappka/main.dart';

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
                //  return cooler;
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
                //  return cpu;
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
               //   return drive;
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
                //  return gpu;
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
               //   return motherboard;
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
              //    return psu;
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
                 // return rams;
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
        )
      ],
    );
  }
}