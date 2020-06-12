
import 'package:flutter/material.dart';
import 'package:wwyck/about.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:wwyck/withdraw.dart';

class Contact extends StatefulWidget {
  // This widget is the root of your application.
  Contact({Key key, @required this.ytext}) : super(key: key);

final String ytext;


@override
  _ContactState createState() => new _ContactState();
}

class _ContactState extends State<Contact> {


   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));



}

String _selectedLocation; 
     String transfer ; String paybills;
    String airtime; String receivefunds; String gitt; String support;
    @override
  void initState() {
    super.initState();
        
    
   
  }
    
    changeText() {
 
     _selectedLocation = gitt;

    if(_selectedLocation !=null)
      {
      if(_selectedLocation =="Chinese")
      {
      
             setState(() {
            transfer = '转账现金'; 
             paybills = '账单支付'; 
             airtime = '通话时间'; receivefunds = '收到资金'; support='客户服务';
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            transfer = 'Transfer Money'; 
             paybills= 'Pay Bills'; 
             airtime = 'Buy Airtime'; receivefunds='Receive Funds'; support='Contact Admin For COT Code';
              });
      }

      //return topHeaderText;
      }
      else{
        setState(() {
            transfer = 'Transfer Money'; 
             paybills= 'Pay Bills'; 
             airtime = 'Buy Airtime'; receivefunds='Receive Funds'; support='Contact Admin For COT Code';
              });
      }
    

  }


  @override
  Widget build(BuildContext context) {

     gitt = widget.ytext;
     changeText();
    return Scaffold(
      
      body: 
      
        Center(
        child: Container(
            
                color: _colorFromHex("000000"),
                child: new Container(
                    padding: const EdgeInsets.only(top:100.0),
         
                  child: new Center(
                       child: new Column( 
                         
                         children: <Widget>[  
                                            
            
       new Card(
         shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.white, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
            
                          color:Colors.lightGreen, 
        child: InkWell(
          splashColor: Colors.blue.withAlpha(50),
          onTap: () {
            print('Card tapped.');
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAbout(rtext:_selectedLocation)),
                 );

          },
          child: Container(
              
           
            width: 300,
            height: 90,
             child:Align(
  alignment: Alignment.center, //
            child: Text(support,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white,
            
            ),
            ),
            ),

          ),
        ),
                ),
      
      
                   
                         ],        
                 ),
                 
                 )
        ),
        ),
        ),
    );
  }
}