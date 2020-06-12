import 'package:flutter/material.dart';
import 'details.dart';
import 'headerText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

import 'custom_button.dart';
import 'customTextField.dart';

class MyRegister extends StatefulWidget {
  // This widget is the root of your application.
  MyRegister({Key key, @required this.ptext}) : super(key: key);

  final String ptext;


@override
  _MyRegisterState createState() => new _MyRegisterState();
}

class _MyRegisterState extends State< MyRegister> {

   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

   }
  //Set Email validator
     

 String emailValide(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty) return '*Required';
      if (!regex.hasMatch(value))
        return '*Enter a valid email';
      else
        return null;
    }



  String _email; String _password;  FocusNode myFocusNode = new FocusNode(); String _username;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _loading;
  bool _autoValidate = false;
  String errorMsg = "";
    final FirebaseAuth auth = FirebaseAuth.instance;
    String _selectedLocation; 
     String topHeaderText ; String createLoginText;
    String emailHint; String passwordHint; String gitt; String usernameHint;
    

  @override
  void initState() {
    super.initState();
    _loading = false;
   
  }

   Future<FirebaseUser>  _validateRegisterInput() async{
       final FormState form = _formKey.currentState;
         _selectedLocation = gitt;
      
      if (_formKey.currentState.validate()) {
        form.save();
    
         setState(() {
                    _loading = true;
                  });
         //////////////////////////////////////////////////////////////////
         ///
try {
   

   
     
 FirebaseUser user = (await auth.createUserWithEmailAndPassword(email: _email, password: _password)).user;  



    user = await auth.currentUser();
    String uid = user.uid;
    // here you write the codes to input the data into firestore

   
  
        
                 // print(_email+_password);
          UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
          userUpdateInfo.displayName = _username;
          user.updateProfile(userUpdateInfo).then((onValue) {
            //Navigator.of(context).pushReplacementNamed('/home');

            
            
            Firestore.instance.collection("users").document().setData(
                {"email":_email , "username": _username, "password":_password,"id":uid}).then((onValue) {
             
                  setState(() {
                    _loading = false;

                     print("User registered successfully");
                    Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => Utility(ytext:_selectedLocation)),
                 );
                  });
                
               
              });
            });
            
  
        } catch (error) {
          switch (error.code) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              {
               
                 
                  if(_selectedLocation=="Chinese") {errorMsg = "该电子邮件已被使用。";}
                else{errorMsg =  "This email is already in use.";}
                       setState(() {
                    _loading = false;
                  });
                  showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            case "ERROR_WEAK_PASSWORD":
              {
               
                 
                 if(_selectedLocation=="Chinese") {errorMsg = "密码长度必须为6个字符或更多。";}
                else{ errorMsg = "The password must be 6 characters long or more.";}
                       setState(() {
                    _loading = false;
                  });
                  showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;

              case "ERROR_INVALID_EMAIL` - If the email address is malformed.":
              {
               
                  if(_selectedLocation=="Chinese") {errorMsg = "密码长度必须为6个字符或更多。";}
                else{  errorMsg = "电子邮件无效，请使用正确格式的电子邮件";}
                       setState(() {
                    _loading = false;
                  });
                  showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
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
              
                  errorMsg = "";
                
              }
          }
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
      
   }

   changeText() {
 
     _selectedLocation = gitt;

    if(_selectedLocation !=null)
      {
      if(_selectedLocation =="Chinese")
      {
      
             setState(() {
            topHeaderText = '建立新帐户'; 
             createLoginText = '登入'; 
             emailHint = '电子邮件'; passwordHint = '密码'; usernameHint='用户名';
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'Create New account'; 
             createLoginText = 'Create A New Account'; 
             emailHint = 'Email'; passwordHint='Password'; usernameHint='Username';
              });
      }

      //return topHeaderText;
      }

      else{
         setState(() {
            topHeaderText = 'Create New account'; 
             createLoginText = 'Create A New Account'; 
             emailHint = 'Email'; passwordHint='Password'; usernameHint='Username';
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
     gitt = widget.ptext;
      changeText();

    return Scaffold(
      body: Center(child:Container( padding: const EdgeInsets.all(30.0), color: _colorFromHex("000000"), child:Center(
        child:Column(
          children: <Widget>[
            Padding(
              
               padding: EdgeInsets.only(bottom: 20),
               
              child: HeaderText(topHeaderText),
              

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
                          child: CustomTextField(
                                onSaved: (input) {
                                _email = input;
                                print(_email);
                              },
                              validator: emailValide,
                              icon: Icon(Icons.email),
                              hint: emailHint,
                              
                            //  label: "Email",
                            //  labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white),
                              )
                              
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CustomTextField( onSaved: (input) {
                                _username = input;
                                 print(_username);
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.account_circle),
                              hint: usernameHint,
                              
                              )
                              
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CustomTextField( onSaved: (input) {
                                _password = input;
                                 print(_password);
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.lock),
                              hint: passwordHint,
                             
                              obsecure: true,
                             
                              )
                        ),

                        

                        Padding(padding: EdgeInsets.only(top: 20),

                        child: CustomButton(
                        onPressed: () {
                        print("Sign In");
                        _validateRegisterInput();

                
              },
              
            ),
                        ),
                         SizedBox(
                          height: 20,
                        ),

                        
                     
                        Padding(padding: EdgeInsets.only(top: 20),

                        
                        
                        child: RaisedButton(
                          color: Colors.black,
                        child:Text(createLoginText,
                        style: TextStyle(
                          fontSize: 20, color: Colors.purple,
                        )
                        ),
                        onPressed: () {
                       // TODO
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyIndex()),
                       );
              },
                        
                        ),
                        ),

                            Padding(padding: EdgeInsets.only(top: 20),

                       
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

 


