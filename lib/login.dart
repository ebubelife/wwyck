import 'package:flutter/material.dart';
import 'headerText.dart';
import 'textfield.dart';


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
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'WWYCk Mobile Banking'),
    );
  }
}

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

   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

  //Set Email validator
     

  
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


  String _email; String _password; static FocusNode myFocusNode = new FocusNode();
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
              child: HeaderText("Sign Into Your Account"),
              

            ),
             SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: MytextField( onSaved: (input) {
                                _email = input;
                              },
                              validator: emailValidator,
                              icon: Icon(Icons.email),
                              hint: "Email",
                              label: "Email",
                              labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white),
                              )
                              
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: MytextField( onSaved: (input) {
                                _password = input;
                              },
                              validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                              icon: Icon(Icons.email),
                              hint: "Password",
                              label: "Password",
                              labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white),
                              )
                        )
            
            
          ],
        )
      )))
    );


}

}