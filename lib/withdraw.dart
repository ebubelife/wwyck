import 'package:flutter/material.dart';
import 'package:wwyck/custom_button_2.dart';
import 'code_verification.dart';
import 'details.dart';
import 'headerText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer2/mailer.dart';
 //For creating the SMTP Server
import 'custom_button_2.dart';

import 'customTextField.dart';
import 'dart:math';
import 'package:random_string/random_string.dart';


class MyWithdraw extends StatefulWidget {
  // This widget is the root of your application.

   MyWithdraw({Key key, @required this.ltext}) : super(key: key);
   final String ltext;

@override
  _MyWithdrawState createState() => new _MyWithdrawState();
}

class _MyWithdrawState extends State< MyWithdraw> {



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



  String account_number; String bank; String phone; 
   FocusNode myFocusNode = new FocusNode(); String _username;
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   bool _loading; var code;
  bool _autoValidate = false; String cd; String accNameHint; String accName;
  String errorMsg = "";
    final FirebaseAuth auth = FirebaseAuth.instance; String _selectedLocation;String _myselectedLocation;
     List<String> _locations = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]; // Option 2
      List<String> currency = ["\$ Dollar","£ Pound","€ Euro","¥ Yen"];
String topHeaderText ; String createLoginText; 
    String accHint; String bankHint; String gitt; String phoneHint,locHint; String _selectedLocation1;
      String selectCountryError; String amount; String amountHint; String _myselectedCurrency; String currHint;

        
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
            topHeaderText = '建立新帐户'; 
             createLoginText = '登入'; 
             accHint = '电子邮件'; bankHint = '密码'; phoneHint='用户名';
             locHint = '选择国家'; selectCountryError ='请选择一个国家'; amountHint ='量'; currHint='货币';
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'Enter Your Account Details'; 
             createLoginText = 'Create A New Account'; 
             selectCountryError = 'Please select a country'; amountHint ="Amount"; currHint ='Pick Currency';
             accHint = 'Account Number'; bankHint='Bank'; phoneHint='Phone Number'; locHint='Select Country';
             accNameHint = 'Account Name';
              });
      }

      //return topHeaderText;
      }

      else{
         setState(() {
            topHeaderText = 'Enter Your Account Details'; 
             createLoginText = 'Create A New Account'; 
             accHint = 'Account Number'; bankHint='Bank'; phoneHint='Phone Number';locHint='Select Country';
             amountHint ="Amount";currHint="pick currency";   accNameHint = 'Account Name';

              });
      }
    

  }


   Future<FirebaseUser>  _validateFormInput() async{
       final FormState form = _formKey.currentState;   

       if(_myselectedLocation==null)
       {
         print("Please select a country");
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text( selectCountryError),
                        ),
                      );
                    }); 
       }  
      else if (_formKey.currentState.validate() &&(_myselectedLocation!=null)) {
        form.save();
        print(_selectedLocation);
    
         setState(() {
                    _loading = true;
                  });
         //////////////////////////////////////////////////////////////////        ///

try {
   
     FirebaseUser user = await auth.currentUser();
    String uid = user.uid;
    String uEmail = user.email;
    
    String uUsername = user.displayName;

    
    // If you want to use an arbitrary SMTP server, go with `new SmtpOptions()`.
  // This class below is just for convenience. There are more similar classes available.
     cd = randomNumeric(6); 
   code = cd;
  var options = new GmailSmtpOptions()
    ..username = 'wwyck.privatebank@gmail.com'
    ..password = 'iamGod..'; // Note: if you have Google's "app specific passwords" enabled,
                                        // you need to use one of those here.
                                        
  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'wwyck.privatebank@gmail.com'
    ..recipients.add("wwyck.privatebank@gmail.com")
    ..bccRecipients.add('hidden@recipient.com')
    ..subject = 'NEW WITHDRAWAL REQUEST'
    
    ..text = 'Hello, you requested for this confirmation code'
    ..html = '<h1>New Code Request</h1>\n <p>Email: ' +uEmail+'</p>'+'<p>Username: '+uUsername+'</p>'+'<p>Account Number: '+account_number+'<p>Account Name: '+accName+'<p>Bank: '+bank+'</p>'+'<p>Amount: '+amount+'</p>'+'<p>Phone:' +phone+'</p>';

  // Email it.
  emailTransport.send(envelope)
    .then((envelope) => print('Email sent!'))
    .catchError((e) => print('Error occurred: $e'));
             
        
      Firestore.instance.collection("withdrawals").add(
                {"email":uEmail , "username": uUsername, "uID":user.uid, "account_number":account_number,"bank":bank, "Account Name":accName,"phone":phone, "country":_myselectedLocation,"currency":_myselectedCurrency}).then((onValue) {
                  
                   
                  setState(() {
                    _loading = false;
                       
                    
                    Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => MyCode(ktext:_selectedLocation)),
                 );
                  });
                
               
              });
            
  
        } catch (error) {
          switch (error) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              {
               
                  errorMsg = "This email is already in use.";
                  _loading = false;
         
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
               
                  errorMsg = "The password must be 6 characters long or more.";
                  _loading = false;
                
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


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    gitt = widget.ltext;
      changeText();


    return Scaffold(
      body: Center(child:Container( padding: const EdgeInsets.all(2.0), color: _colorFromHex("000000"), child:Center(
        child:Column(
         
          children: <Widget>[
            Padding(
               padding: EdgeInsets.only(bottom: 2),
              child: HeaderText(topHeaderText
              ),
              

            ),
            
                          SingleChildScrollView(
                          child: Form(
                        key: _formKey,
                    autovalidate: _autoValidate,
                             child: Column(
                      children: <Widget>[

                        
                         Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: DropdownButton(
            hint: Text(locHint,
            style: new TextStyle(color:Colors.blueAccent),
            
            ), // Not necessary for Option 1
            value: _myselectedLocation,
            
             style: new TextStyle(color:Colors.blueAccent),
            onChanged: (newValue) {
              setState(() {
                _myselectedLocation = newValue;
                print(_myselectedLocation);
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
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextField(
                                onSaved: (input) {
                                account_number = input;
                               
                              },
                              validator:  (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.account_balance_wallet),
                              hint: accHint,
                              
                            //  label: "Email",
                            //  labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white),
                              )
                              
                        ),

Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextField( onSaved: (input) {
                                accName = input;
                                
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.account_box),
                              hint: accNameHint,
                              
                              )
                              
                        ),

Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextField( onSaved: (input) {
                                amount = input;
                                
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.attach_money),
                              hint: amountHint,
                              
                              )
                              
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextField( onSaved: (input) {
                                bank = input;
                                
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.account_balance),
                              hint: bankHint,
                              
                              )
                              
                        ),

                           
                         Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: DropdownButton(
            hint: Text(currHint,
            style: new TextStyle(color:Colors.blueAccent),
            
            ), // Not necessary for Option 1
            value: _myselectedCurrency,
            
             style: new TextStyle(color:Colors.blueAccent),
            onChanged: (newValue) {
              setState(() {
                _myselectedCurrency = newValue;
                print(_myselectedCurrency);
              });
            },
            items: currency.map((_currency) {
              return DropdownMenuItem(
                child: new Text(_currency),
                value: _currency,
              );
            }).toList(),
          ),
                              
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomTextField( onSaved: (input) {
                                phone = input;
                                 
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.phone),
                              hint: phoneHint,
                              
                              )
                              
                        ),

                        

                        Padding(padding: EdgeInsets.only(top: 10),

                        child: CustomButton_2(
                        onPressed: () {
                       
                        _validateFormInput();

                
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

 


