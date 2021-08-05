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
    return Container(
      padding: EdgeInsets.all(15),
      
      child:ElevatedButton(
        style:ButtonStyle(),
        child: new Icon(          
          Icons.add,
          color: Colors.white,
          size: 40.0,
          ),
        onPressed: null ),
    );
  }
  Widget itemFrame(String name, {Image photo}){
    if(photo == null) photo = Image.asset('assets/placeholder.png',fit: BoxFit.cover);         
    return Container(      
      padding: EdgeInsets.all(15),
      child:Column(
         children:[   
         photo,
         Text(name)
      ],
    ));
  }

  void _onItemTapped(int index){
    ktoro=index;
    main();
  }


  @override
  Widget build(BuildContext context) { //build context gives the layout, when you build widget it will always have this line
    return Scaffold( //entry point to your app scaffold blank display
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(102, 7, 8, 100),
        //leading: Icon(Icons.computer),
        title: Text('Składappka',
          style: TextStyle(fontFamily: 'Lobster-1.4',fontWeight: FontWeight.w400,fontSize: 34),),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            itemFrame('name'),
            addButton('')
            
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
        selectedItemColor: Color.fromRGBO(102, 7, 8,100) ,
        onTap: _onItemTapped,
      ),
    );
  }
}