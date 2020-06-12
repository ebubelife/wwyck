import 'package:flutter/material.dart';
import 'package:wwyck/details.dart';
import 'package:wwyck/headerText.dart';


class MyAbout extends StatefulWidget {
  // This widget is the root of your application.
   MyAbout({Key key, @required this.rtext}) : super(key: key);
   final String rtext;

@override
  _MyAboutState createState() => new _MyAboutState();
}

class _MyAboutState extends State< MyAbout> {



   Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));

   }
  //Set Email validator

  String topHeaderText ; String createLoginText;
  String emailHint; String passwordHint; String gitt; String usernameHint; String _selectedLocation;
  String aboutTextEnglish1 = "We never stop looking for new ways to make banking simpler, smarter and better. WWYCK Online Banking Service gives you unrestricted and secure access to your account, anytime, anywhere on your computer, tablet, smartphones or any mobile device. Welcome to banking on the go!\n";
  String aboutTextEnglish2 = "We recommend using our online help first but if you'd still rather get in touch, Email us on (wwyck.privatebank@gmail.com) We receive a lot of mails every day so email wait times will vary during busy periods";
  String aboutTextCh1 ="我们永不停止寻找使银行变得更简单，更智能，更好的新方法。 WWYCK网上银行服务使您可以随时随地在计算机，平板电脑，智能手机或任何移动设备上不受限制地安全访问帐户。欢迎随时随地使用银行！";
  String aboutTextCh2 = "我们建议您首先使用在线帮助，但如果您仍然希望保持联系，请给我们发送电子邮件（wwyck.privatebank@gmail.com）。我们每天都会收到大量邮件，因此在繁忙时段电子邮件等待时间会有所不同";
  String backText;
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
            topHeaderText = '关于WWYCK'; 
             createLoginText = aboutTextCh1+aboutTextCh2; 
             backText = '返回选项页面';
             
             
              });
      }
      
      else if(_selectedLocation =="English")
      {
        
           setState(() {
            topHeaderText = 'ABOUT WWYCK'; 
             createLoginText = aboutTextEnglish1 + aboutTextEnglish2; 
             backText = 'Back To Options';
            
              });
      }

      //return topHeaderText;
      }

      else{
         setState(() {
             topHeaderText = 'ABOUT WWYCK'; 
             createLoginText = aboutTextEnglish1+aboutTextEnglish2; 
           
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
    gitt = widget.rtext;
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
            
                          SingleChildScrollView(
                         
                             child: Column(
                      children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(top: 3),

                          child: Card(
         shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
            
                          color:Colors.black, 
        child: InkWell(
          splashColor: Colors.blue.withAlpha(50),
          onTap: () {
            //print('Card tapped.');

          },
          child: Container(
              
           
            width: 300,
            height: 460,
             child:Align(
  alignment: Alignment.center, //
            child: Text(createLoginText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white,
            
            ),
            ),
            ),

          ),
        ),
                ),
      
                        ),
                         SizedBox(
                          height: 10,
                        ),

                         Padding(padding: EdgeInsets.only(top: 10),

                        
                        
                        child: RaisedButton(
                          color: Colors.black,
                        child:Text(backText,
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

 


