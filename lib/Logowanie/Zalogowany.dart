import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skladappka/Firebase/Builds.dart';
import 'package:skladappka/Firebase/FireBase.dart';
import 'package:skladappka/Firebase/doLogowanie/doLogowanie.dart';
import 'package:skladappka/config/fileOperations.dart';
import 'package:skladappka/Globalne.dart' as globalna;
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:skladappka/wczytajZestaw/wczytajZestaw.dart';
import 'package:skladappka/main.dart';

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

  Widget chooseAvatar(BuildContext c) {
    return SimpleDialog(
      title: Text('Wybierz swój awatar:'),
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
          )
      ],
    );
  }

  Widget buildItem(IconData icon, String text) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Icon(icon,
        size: 20,)
        ),
        Container(
           margin:   EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: 100,
          child: Text(
            text,
            style: TextStyle(fontSize: 13),
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
    builds.sort((a,b){
      var dateA= a.timestamp;
      var dateB= b.timestamp;
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
                Container(
                  height: 70,
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext c) => chooseAvatar(c));
                    },
                    child: Stack(fit: StackFit.passthrough, children: [
                      ClipRRect(
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
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment(1.2, 1.2),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(240, 84, 84, 1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: FutureBuilder<String>(
                      future: getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print(snapshot.data);
                          final username = snapshot.data;
                          return AutoSizeText(
                            'Witaj, $username',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context).accentColor),
                          );
                        } else
                          return CircularProgressIndicator();
                      }),
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
                fontSize: 21,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).accentColor),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.5, color: Color.fromRGBO(240, 84, 84, 1)),
                borderRadius: BorderRadius.circular(2)),
            height: MediaQuery.of(context).size.height * 0.5,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                child: ListView.builder(
                    itemCount: builds.length,
                    itemBuilder: (context, i) {
                      final item = builds[i];
                      return Dismissible(
                        //direction: DismissDirection.endToStart,
                        key: Key(Uuid().v4().toString()),
                        background: Container(
                          padding: EdgeInsets.only(left: 20),
                          color: Colors.blue,
                           child: Align(alignment: Alignment.centerLeft,child: Icon(Icons.edit,color: Colors.white,))
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: Align(alignment: Alignment.centerRight,child: Icon(Icons.delete,color: Colors.white,))
                        ),
                        onDismissed: (DismissDirection direction){
                          if(direction== DismissDirection.startToEnd){
                            globalna.ktoro=1;
                           inicjalizuj(item);
                          }
                          else{   
                                                                               
                            setState(() {
                              FirebaseFirestore.instance
                              .collection("builds")
                              .doc(builds[i].generatedCode + " " + builds[i].uid).delete();  
                              builds.remove(i);
                            });
                          }

                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.height * 0.5,
                            height: 150,
                            color: Theme.of(context).shadowColor,
                            child: Wrap(
                              children: [      
                                Center(child: Text('Zestaw z '+builds[i].timestamp.substring(0,16),
                                style: TextStyle(
                                  fontSize: 17
                                ),)),
                                                         
                                buildItem(Icons.select_all, builds[i].cpuId),
                                buildItem(Icons.tv_sharp, builds[i].gpuId),
                                buildItem(
                                    Icons.keyboard_alt_sharp, builds[i].ramId),
                                buildItem(
                                    Icons.dynamic_form_sharp, builds[i].psuId),
                                buildItem(Icons.local_laundry_service_sharp,
                                    builds[i].driveId),
                                buildItem(Icons.view_sidebar_sharp, builds[i].motherboardId),
                                buildItem(Icons.crop_5_4_sharp, builds[i].caseId),
                                buildItem(Icons.ac_unit, builds[i].coolerId),
                              ],
                            )),
                      );
                    }))),
        TextButton(
            onPressed: () async {
              logout();
            },
            child: Text('Wyloguj'))
      ]),
    );
  }
}
