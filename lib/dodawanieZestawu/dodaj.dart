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
    return Column(
      children:[
        Text(component),
       Container(
      padding: EdgeInsets.all(15),
      
      child:ElevatedButton(
        style:ButtonStyle(),
        child: new Icon(          
          Icons.add,
          color: Colors.white,
          size: 40.0,
          ),
        onPressed: null ),
    )]);
  }
  Widget itemFrame(String model, String name ,{Image photo}){        
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Text(name),
      Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ), 
      width: MediaQuery.of(context).size.width / 2,   
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      child:Column(
         children:[
        //Text(name),
        AspectRatio(          
         // aspectRatio: 487 / 386,
         aspectRatio: 4/3,
          child: Container(
           decoration: BoxDecoration(
             border: Border.all(width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
             image: DecorationImage(                
               fit: BoxFit.fitWidth,
               alignment: FractionalOffset.center,
               image: new AssetImage('assets/placeholder.png')
             ),

           ),
         )),
         Text(
           model,           
           style: TextStyle(
             
             
           ),
         )
      ],
    ))]);
  }

  void _onItemTapped(int index){
    ktoro=index;
    inicjalizuj();
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          crossAxisCount: 2,
          children: [            
            itemFrame('name','CPU:'),
            itemFrame('name','GPU:'),            
            itemFrame('name','RAM:'),
            addButton('component'),
            addButton('component'),
            addButton('component')
            
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