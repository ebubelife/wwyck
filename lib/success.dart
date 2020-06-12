import 'package:flutter/material.dart';
import 'details.dart';
import 'headerText.dart';


class MySuccess extends StatefulWidget {
  // This widget is the root of your application.
   MySuccess({Key key, @required this.utext}) : super(key: key);
   final String utext;

@override
  _MySuccessState createState() => new _MySuccessState();
}

class _MySuccessState extends State< MySuccess> {



   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

   }
  //Set Email validator

   String topHeaderText ; String createLoginText;
    String emailHint; String passwordHint; String gitt; String usernameHint; String _selectedLocation;
     

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
            topHeaderText = '成功！'; 
             createLoginText = '提款成功！您很快就会收到您的资金'; 
             
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'Successful!'; 
             createLoginText = 'Withdrawal succesful! You\'ll soon receive your funds'; 
            
              });
      }

      //return topHeaderText;
      }

      else{
         setState(() {
             topHeaderText = 'Successful!'; 
             createLoginText = 'Withdrawal succesful! You\'ll soon receive your funds'; 
           
              });
      }
    

  }
  


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
     gitt = widget.utext;
    changeText();

    return Scaffold(
      body: Center(child:Container( padding: const EdgeInsets.all(10.0), color: _colorFromHex("000000"), child:Center(
        child:Column(
          children: <Widget>[
            Padding(
               padding: EdgeInsets.only(bottom: 10),
              child: HeaderText(topHeaderText
              ),
              

            ),
             SizedBox(
                          height: 20,
                        ),
                          SingleChildScrollView(
                         
                             child: Column(
                      children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(top: 20),

                          child: Card(
         shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.white, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
            
                          color:Colors.lightGreen, 
        child: InkWell(
          splashColor: Colors.blue.withAlpha(50),
          onTap: () {
            //print('Card tapped.');

          },
          child: Container(
              
           
            width: 300,
            height: 130,
             child:Align(
  alignment: Alignment.center, //
            child: Text(createLoginText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white,
            
            ),
            ),
            ),

          ),
        ),
                ),
      
                        ),
                         SizedBox(
                          height: 20,
                        ),

                         Padding(padding: EdgeInsets.only(top: 20),

                        
                        
                        child: RaisedButton(
                          color: Colors.black,
                        child:Text("Back To Options",
                        style: TextStyle(
                          fontSize: 20, color: Colors.purple,
                        )
                        ),
                        onPressed: () {
                       // TODO
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Utility()),
                       );
              },
                        
                        ),
                        ),

                        
                      ],
                    ),
                      
                    ),
            
          ],
        )
      )))
    );


}

   }

 


