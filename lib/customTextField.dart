import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 16,
          color:Colors.white,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color:Colors.grey),
            hintText: hint,
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
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Colors.blueAccent),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}