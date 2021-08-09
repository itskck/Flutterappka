import 'package:flutter/material.dart';
import 'package:skladappka/main.dart';
class dodaj extends StatefulWidget {
  dodaj({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _dodaj createState() => _dodaj();
}
class _dodaj extends State<dodaj>{
  int _selectedIndex=0;


  Widget addButton(String component)
  {
    return GestureDetector(
      onTap: (){
        print('tapped');
      },      
      child: Container(
        margin: EdgeInsets.all(15),
         width: 500,
         height: 500,
         decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color.fromRGBO(240, 84, 84, 1), width: 2) ,
          color: Color.fromRGBO(48, 71, 94, 170)
        ),        
        child: Text(
          '$component '*150,
          
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            foreground: Paint()
              ..style= PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Color.fromRGBO(255, 255, 255, 50)

          ),
        ),
      )        
    );
  }
  Widget itemFrame(String model, String name ,{Image photo}){        
    return Container(
      constraints: BoxConstraints.expand(),
      margin: EdgeInsets.all(15),
      width: 500,
     
      child: Column(
      
      
      children: [
        Container(
          //height:  
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(10)) ),
        ),
        Text(model)
      ]));
  }

  void _onItemTapped(int index){
    ktoro=index;
    inicjalizuj();
  }


  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Scaffold( //entry point to your app scaffold blank display
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(240, 84, 84, 1),
        //leading: Icon(Icons.computer),
        title: Text('Składappka',
          style: TextStyle(fontFamily: 'Lobster-1.4',fontWeight: FontWeight.w400,fontSize: 34),),
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          crossAxisCount: 2,
          children: [            
            addButton('CPU'),
            addButton('MTBD'),
            addButton('RAM'),
            addButton('PSU'),
            addButton('DRIVE'),
            addButton('CASE'),
            
            
          ],),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj zestaw',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_download),
            label: 'Wczytaj zestaw',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Strona główna',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Porównywarka'),
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Zaloguj')
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(61, 25, 91, 100) ,
        onTap: _onItemTapped,
      ),
    );
  }
}