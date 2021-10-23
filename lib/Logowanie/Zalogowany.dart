import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/Logowanie/Logowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:skladappka/wczytajZestaw/wczytajZestaw.dart';
import 'package:skladappka/main.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Zalogowany extends StatefulWidget {
  Zalogowany({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Zalogowany createState() => _Zalogowany();
}

class _Zalogowany extends State<Zalogowany> {
  final doLogowanie _auth = doLogowanie();
  final file = fileReader();

  final List<Image> avatarList = [
    Image.asset('assets/avatars/1.png'),
    Image.asset('assets/avatars/2.png'),
    Image.asset('assets/avatars/3.png'),
    Image.asset('assets/avatars/4.png'),
    Image.asset('assets/avatars/5.png'),
  ];

  List<String> nicknames;
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> getBuildsList() async {
    var builds = await FireBase().builds;
    return builds;
  }

  Future<int> getAvatarNumber() async {
    var chosenAvatar;
    await FirebaseFirestore.instance
        .collection("users")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((QuerySnapshot result) => {
              result.docs.forEach((element) {
                if (element['aid'] != null)
                  chosenAvatar = element['aid'];
                else
                  chosenAvatar = 0;
              })
            });
    print(chosenAvatar.toString() + "yooooooooooooo");
    return chosenAvatar;
  }

  void logout() async {
    await _auth.wylogui();
    file.save("czyZalogowany=false");
    globalna.czyZalogowany = "czyZalogowany=false";
    dynamic result = await _auth.Anonim();
    print(result);
  }

  Future<String> getUsername() async {
    var username;
    print(FirebaseAuth.instance.currentUser.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((QuerySnapshot result) => {
              result.docs.forEach((element) {
                print(FirebaseAuth.instance.currentUser.uid);
                username = element['nick'];
              })
            });

    return username;
  }

  Widget removeAcc(BuildContext c){
   
    return AlertDialog(
      title: Text('Czy chcesz usunąć swoje konto?',style: TextStyle(fontSize: 18),),
      actions: [
        TextButton(child: Text('Tak'),
        onPressed: (){
          Logowanie();
          doLogowanie().deleteUser();
          Navigator.pop(c);
          
        },),
        TextButton(child: Text('Nie'),
        onPressed: (){
          Navigator.pop(c);
        },),
      ],
    );
  }

  Widget chooseAvatar(BuildContext c) {
    return SimpleDialog(
      title: Center(child: Text('Wybierz swój awatar:')),
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (int i = 0; i < avatarList.length; i++)
             SimpleDialogOption(
            child: Container(height: 50, width: 50, child: avatarList[i]),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .update({'aid': i});
              setState(() {});
              Navigator.pop(c);
            },
          ),
          ],
        ),
        
        
        Container(
          margin: EdgeInsets.fromLTRB(35, 20, 35, 0),
          width: 50,
          height: 40,
          child: TextField(
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             labelText: 'Edytuj nazwę użytkownika',
             isDense: true,
             contentPadding: EdgeInsets.all(8)
           ),
          ),
        )
        ],
    );
  }

  Widget buildItem(IconData icon, String text) {
    return Wrap(
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: 100,
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final builds = Provider.of<List<Builds>>(context) ?? [];
    print("aaaaaaa");
    print(builds.length);
    print("aaaaaaa");
    builds.sort((a, b) {
      var dateA = a.timestamp;
      var dateB = b.timestamp;
      return -dateA.compareTo(dateB);
    });
    return Center(
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 0, 50),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 70,
                      child: ClipRRect(
                          child: FutureBuilder<int>(
                            future: getAvatarNumber(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                return avatarList[snapshot.data];
                              else
                                return Container();
                            },
                          ),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: FutureBuilder<String>(
                          future: getUsername(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              print(snapshot.data);
                              final username = snapshot.data;
                              return AutoSizeText(
                                'Witaj, $username',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              );
                            } else
                              return CircularProgressIndicator();
                          }),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext c) => chooseAvatar(c));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 23),
                        padding: EdgeInsets.all(2),
                        width: 100,
                        height: 30,
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(45, 45, 45, 1),
                          ),
                          child: Center(
                            child: Text(
                              'Edytuj profil',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.80, 0),
          child: Text(
            'Twoje zestawy: ',
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
        Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(142, 223, 255, 1),
                      Color.fromRGBO(255, 0, 140, 1)
                    ])),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(45, 45, 45, 1),
                ),
                child: ListView.builder(
                    itemCount: builds.length,
                    itemBuilder: (context, i) {
                      final item = builds[i];
                      return Column(
                        children: [
                          Dismissible(
                            //direction: DismissDirection.endToStart,
                            key: Key(Uuid().v4().toString()),
                            background: Container(
                                padding: EdgeInsets.only(left: 20),
                                color: Colors.blue,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ))),
                            secondaryBackground: Container(
                                padding: EdgeInsets.only(right: 20),
                                color: Colors.red,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ))),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.startToEnd) {
                                globalna.ktoro = 1;
                                return inicjalizuj(item);
                              } else {
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection("builds")
                                      .doc(builds[i].generatedCode +
                                          " " +
                                          builds[i].uid)
                                      .delete();
                                  builds.remove(i);
                                });
                              }
                            },
                            child: IntrinsicHeight(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.5,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Zestaw z ' +
                                                builds[i]
                                                    .timestamp
                                                    .substring(0, 10),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "Kod: " +
                                                      builds[i].generatedCode,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              IconButton(
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: builds[i]
                                                                .generatedCode));
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Skopiowano kod do schowka",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity
                                                            .BOTTOM);
                                                  },
                                                  icon: Icon(
                                                    Icons.share,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )
                                        ],
                                      )),
                                      buildItem(
                                          Icons.select_all, builds[i].cpuId),
                                      buildItem(
                                          Icons.tv_sharp, builds[i].gpuId),
                                      buildItem(Icons.keyboard_alt_sharp,
                                          builds[i].ramId),
                                      buildItem(Icons.dynamic_form_sharp,
                                          builds[i].psuId),
                                      buildItem(
                                          Icons.local_laundry_service_sharp,
                                          builds[i].driveId),
                                      buildItem(Icons.view_sidebar_sharp,
                                          builds[i].motherboardId),
                                      buildItem(Icons.crop_5_4_sharp,
                                          builds[i].caseId),
                                      buildItem(
                                          Icons.ac_unit, builds[i].coolerId),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 1,
                          )
                        ],
                      );
                    }))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: 100,
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
                child: TextButton(
                    onPressed: () async {
                      logout();
                    },
                    child: Text('Wyloguj',style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: 100,
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
            child: TextButton(
                onPressed: () async {
                  await showDialog(context: context, builder: (BuildContext c) => removeAcc(c) );
                },
                child: Text('Usuń konto',style: TextStyle(
                  color: Colors.white
                ),)),
          ),
        )
          ],
        ),
        
      ]),
    );
  }

  
}


