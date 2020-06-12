

import 'package:flutter/material.dart';
import 'customTextField.dart';
import 'details.dart';
import 'headerText.dart';
import 'register.dart';
import 'custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';



void
 main() {
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  // This widget is the root of your application.

@override
  _MyAppState createState() => new _MyAppState();
}


class _MyAppState extends State<MyApp> {
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WWYCK Mobile Banking',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.purple[900],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyIndex(title: 'WWYCK Mobile Banking'),
    );
  }
}
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class MyIndex extends StatefulWidget {
   MyIndex({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  


  @override
  _MyIndexState createState() => _MyIndexState();
}




class _MyIndexState extends State< MyIndex> {

  String textHolder = 'Old Sample Text...!!!';
 
  

   String _email; String _password;  FocusNode myFocusNode = new FocusNode(); String _username;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _loading;
  bool _autoValidate = false;
  String errorMessage = "";
    final FirebaseAuth auth = FirebaseAuth.instance;String _selectedLocation; 
    List<String> _locations = ["Chinese","English"]; String topHeaderText ; String createLoginText;
    String emailHint; String passwordHint;
    


   @override
  void initState() {
    super.initState();
    _loading = false;
    topHeaderText = "Sign Into Your Account";
    createLoginText = "Create New Account";
    emailHint = "Email"; passwordHint = 'password';
  }

   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

  //Set Email validator

  

  
}

changeText() {
 
    

    if(_selectedLocation !=null)
      {
      if(_selectedLocation =="Chinese")
      {
      
             setState(() {
            topHeaderText = '登录到您的帐户'; 
             createLoginText = '创建一个新账户'; 
             emailHint = '电子邮件'; passwordHint = '密码';
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'Sign Into Your Account'; 
             createLoginText = 'Create A New Account'; 
             emailHint = 'Email'; passwordHint='Password';
              });
      }

      //return topHeaderText;
      }

      else{
        setState(() {
            topHeaderText = 'Sign Into Your Account'; 
             createLoginText = 'Create A New Account'; 
             emailHint = 'Email'; passwordHint='Password';
              });
      }
    

  }

 String emailValidator(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty) return '*Required';
      if (!regex.hasMatch(value))
        return '*Enter a valid email';
      else
        return null;
    }
 





    void _validateLoginInput() async{
       final FormState form = _formKey.currentState;
      if (_formKey.currentState.validate()) {
        form.save();
         //////////////////////////////////////////////////////////////////
     

                      setState(() {
                    _loading = true;
                  });

try {
      

          FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)).user;
         // Navigator.of(context).pushReplacementNamed('/home');
        //         
         setState(() {
                    _loading = false;
                  });
                  print(_selectedLocation);

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Utility(ytext:_selectedLocation)),
              
                 );
        } catch (error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
      {
      
         if(_selectedLocation=="Chinese") {errorMessage = "您的电子邮件地址似乎格式错误。";}
       else{errorMessage =  "Your email address appears to be malformed.";}
        setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
      }
        break;
      case "ERROR_WRONG_PASSWORD":
      {
       
       if(_selectedLocation=="Chinese") { errorMessage = "您的密码错误";}
       else{errorMessage = "Your password is wrong.";}
        setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
      }
        break;
      case "ERROR_USER_NOT_FOUND":
      {
       if(_selectedLocation=="Chinese") {errorMessage =  "使用此电子邮件的用户不存在";}
       else{errorMessage = "User with this email doesn't exist."; }
        setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
      }
        break;
      case "ERROR_USER_DISABLED":
      {
       
        if(_selectedLocation=="Chinese") { errorMessage =  "此帐户已被禁用。";}
       else{errorMessage = "This account has been disabled.";}
        setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
      }
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      {
       
       if(_selectedLocation=="Chinese") {  errorMessage =  "请求太多。稍后再试。";}
       else{errorMessage = "Too many requests. Try again later."; }
         setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
      }
        
        break;
      default:
       
        if(_selectedLocation=="Chinese") { errorMessage =  "发生未定义的错误。";}
       else{errorMessage = "An undefined Error happened."; }
       
         setState(() {
                    _loading = false;
                  });
       showDialog(
         
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMessage),
                        ),
                      );
                    });
    }
  }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
        

    }


    ////////////////////////

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
     

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
                          child: DropdownButton(
            hint: Text('English',
            style: new TextStyle(color:Colors.blueAccent),
            
            ), // Not necessary for Option 1
            value: _selectedLocation,
            
             style: new TextStyle(color:Colors.blueAccent),
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue;
                changeText();
                print(_selectedLocation);
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
                              
                        ),
            
                         Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CustomTextField( onSaved: (input) {
                                _email = input;
                               // print(_email);
                              },
                              validator: emailValidator,
                              icon: Icon(Icons.email),
                              hint: emailHint,
                             
                              )
                              
                        ),
                         Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CustomTextField( onSaved: (input) {
                                _password = input;
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
                       _validateLoginInput();
                
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
                        MaterialPageRoute(builder: (context) => MyRegister(ptext:_selectedLocation,)),
                       );
              },
                        
                        )
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


