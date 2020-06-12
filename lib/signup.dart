import 'package:flutter/material.dart';
import 'custom_button.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // int _counter = 0;
 List<String> _locations = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"]; // Option 2
  String _selectedLocation; // Option 2
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();



 Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
     
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
            padding: const EdgeInsets.all(30.0),
            
                color: _colorFromHex("000000"),
                child: new Container(
                 
                  child: new Center(
                    
                    child: new Column(
                     children : [
                       new Padding(padding: EdgeInsets.only(top: 50.0)),
                       new Text('Sign In To Your Account',
                       style: new TextStyle(color: Colors.blueAccent, fontSize: 25.0),),
                       new Padding(padding: EdgeInsets.only(top: 30.0)),
                       //Set full name input field

                       new DropdownButton(
            hint: Text('Please choose a location',
            style: new TextStyle(color:Colors.blueAccent),
            
            ), // Not necessary for Option 1
            value: _selectedLocation,
             style: new TextStyle(color:Colors.blueAccent),
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue;
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
          new Padding(padding: EdgeInsets.only(top: 10.0)),
                       new TextFormField(
                         enabled: true, // to trigger disabledBorder
                         focusNode: myFocusNode1,
                        
                      decoration: new InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: myFocusNode1.hasFocus ? Colors.white : Colors.white),
                        fillColor: Colors.white,
                        
                        focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.blue),
   ),
   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.orange),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.green),
   ),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,)
   ),
   errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.black)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
   ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return "Full name cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white
                      ),
                    ),
                     new Padding(padding: EdgeInsets.only(top: 10.0)),
                     //Set account number input
                     new TextFormField(
                        enabled: true, // to trigger disabledBorder
                         focusNode: myFocusNode2,
                      decoration: new InputDecoration(
                        labelText: "Password",
                         labelStyle: TextStyle(color: myFocusNode2.hasFocus ? Colors.white : Colors.white),
                       
                        fillColor: Colors.white,
                         
                       focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.blue),
   ),
   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.orange),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.green),
   ),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,)
   ),
   errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.black)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(25.0)),
     borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
   ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return "Account number cannot be empty";
                        }else{
                          return null;
                        }
                      },
                      autofocus: false,
                      obscureText: true,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white
                      ),
                    ),
                    //Set email address input
                     new Padding(padding: EdgeInsets.only(top: 10.0)),
                    
                                  
                    //Sign In Button
                    new Padding(padding: EdgeInsets.only(top: 10.0)),
            CustomButton(
              onPressed: () {
                print("Sign In");
                
              },
            ),
              new Padding(padding: EdgeInsets.only(top: 20.0)),
             Text("Create An Account",
            style: TextStyle(color:Colors.blue,fontSize: 20,),
             )
                  ]
                    )
                    
                 ),
                 
                 )
        ),
  
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    
    );
  }
}
