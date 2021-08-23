import 'package:flutter/material.dart';

class dialogWidget{
  
    
  void showPopup(BuildContext context,String component) => showDialog(
    context: context,
    builder: (BuildContext context) => popupWindow(context, component) 
  );
  
  Widget popupWindow(BuildContext context, String component) {
    print('tiroro $component');
    return SimpleDialog(      
      title: Text('Choose your $component: '),
      children: [
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          child: Text('some kind of $component'),
          onPressed: (){
            Navigator.pop(context);

          },
        )
      ],      
      
    );
  }
}