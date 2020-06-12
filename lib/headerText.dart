import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget{
  HeaderText(
    //This method holds all properties of the text
    this.text
   );


    final String text;
  

     @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(left: 20, right: 20,top:70),
      child: Text(text, textAlign: TextAlign.center,
                       style: new TextStyle(color: Colors.blueAccent, fontSize: 22.0,),),
    );
  }

}