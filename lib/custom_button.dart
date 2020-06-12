import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
 
class CustomButton extends StatelessWidget {
  CustomButton(
    {@required this.onPressed});
  final GestureTapCallback onPressed;
 
 
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.green,
      splashColor: Colors.greenAccent,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.check,
              color: Colors.amber,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "",
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}