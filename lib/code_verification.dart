import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wwyck/details.dart';
import 'package:wwyck/headerText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wwyck/main.dart';

import 'package:wwyck/custom_button.dart';
import 'package:wwyck/customTextField.dart';
import 'package:wwyck/success.dart';

class MyCode extends StatefulWidget {
  // This widget is the root of your application.
   MyCode({Key key, @required this.ktext}) : super(key: key);
   final String ktext;


@override
  _MyCodeState createState() => new _MyCodeState();
}

class _MyCodeState extends State< MyCode> {



   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

   }
  //Set Email validator
     




  String codeinput;  String code;
   FocusNode myFocusNode = new FocusNode(); String _username;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _loading;
  bool _autoValidate = false;
  String errorMsg; String wrongCode;
    final FirebaseAuth auth = FirebaseAuth.instance; String _selectedLocation; 
    final databaseReference = Firestore.instance; String codef; String topHeaderText; String trequired; String gitt;
    

  @override
  void initState() {
    super.initState();
    _loading = false;
  
  }

 
 changeText() {
 
     _selectedLocation = gitt;

    if(_selectedLocation !=null)
      {
      if(_selectedLocation =="Chinese")
      {
      
             setState(() {
            topHeaderText = '在此处输入COT代码（检查电子邮件以获取代码）'; 
             trequired = '必填项目';  wrongCode = '该代码是错误的，请重试';
            
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'Enter COT Code From Email'; 
             trequired = 'Field Required'; 
            wrongCode = 'That code is wrong please try again!';
              });
      }

      //return topHeaderText;
      }

      else{
         setState(() {
            topHeaderText = 'Enter COT Code Here(Check Email For Code)'; 
             trequired = 'Field Required'; 
              wrongCode = 'That code is wrong please try again!';
            
              });
      }
    

  }

  Future<FirebaseUser> _val() async{

            final FormState form = _formKey.currentState;   
            if (_formKey.currentState.validate())
            {
            form.save();
      final firestoreInstance = Firestore.instance;
      FirebaseUser user = await auth.currentUser();
    
    print('My Code: $codeinput');
   

    firestoreInstance
    .collection("codes")
    .where("code", isEqualTo: code)
    .getDocuments()
    .then((value) {
  value.documents.forEach((result) {
    //print(result.data["code"]);
     
    codef = result.data["code"];
    if(codef==codeinput)
    {
     
      print('$codef fknjsdnk');
      

                     Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => MySuccess(utext:_selectedLocation)),
                 );
                 
  
    }
    else
    {
      // print (codef); print(result.data["code"]);
       showDialog(
                    context: context,
                    builder: (
                      BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(wrongCode),
                        ),
                      );
                    });
    }
  });
    });
  
return user ;
            }
     
  }


   Future<FirebaseUser>  _validateFormInput() async{
       final FormState form = _formKey.currentState;   

      
       if (_formKey.currentState.validate()) {
        form.save();
       
    
         setState(() {
                    _loading = true;
                  });
         //////////////////////////////////////////////////////////////////        ///

try {
  
     FirebaseUser user = await auth.currentUser();
                   String uUsername = user.email;

                           Firestore.instance.collection("codes").document(uUsername).setData(
                {"code":codeinput}).then((onValue) {
                //  print(g);
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MySuccess(utext:_selectedLocation)),
                       );

                  
                }
                );

    
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MySuccess(utext:_selectedLocation)),
                       );

    
    
   
        
        } catch (error) {
          switch (error) {
            case "WRONG_CODE":
              {
               
                  errorMsg = "The code is wrong, pls re-enter";
                  _loading = false;
         
                showDialog(
                    context: context,
                    builder: (
                      BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
           
            default:
              {
              
                  errorMsg = "Unexpected error";
                
              }
          }
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }

     
      
   }


  @override
  Widget build(BuildContext context) {

    gitt = widget.ktext;
      changeText();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


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
                          child: Form(
                        key: _formKey,
                    autovalidate: _autoValidate,
                             child: Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CustomTextField( onSaved: (input) {
                                codeinput = input;
                                                               
                              },
                              validator: (input) =>
                                  input.isEmpty ? trequired : null,
                              icon: Icon(Icons.edit),
                              hint: "xxxxxx",
                              
                              )
                              
                        ),
                        
                        Padding(padding: EdgeInsets.only(top: 20),

                        child: CustomButton(
                        onPressed: () {
                   // print(codeinput);
                       _val();
                         
                
              },
            ),
                        ),
                         SizedBox(
                          height: 20,
                        ),

                        
                     
                        

                            Padding(padding: EdgeInsets.only(top: 10),

                       
                          child: _loading == true
                              ? CircularProgressIndicator(
                                   backgroundColor: Colors.white,
                                   strokeWidth: 5,
                                )
                           :Container(),             
                       )
                      ],
                    ),
                      ),
                    ),
            
          ],
        )
      )))
    );


}

   }

 


