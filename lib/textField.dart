import 'package:flutter/material.dart';

class MytextField extends StatelessWidget{
     MytextField({
      this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved,
      this.label, this.keyboardType,
      this.labelStyle,
     
});

  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final String label;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  static FocusNode myFocusNode = new FocusNode();
   TextStyle labelStyle = new TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white);

   @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left: 20, right: 20),
    child:TextFormField(autofocus: true, validator:validator,obscureText: obsecure, 
                      keyboardType:keyboardType ,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white
                      ),
                        decoration: new InputDecoration(
                        labelText: label,
                        labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.white : Colors.white),
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
                        )
    )
    );
  }


}