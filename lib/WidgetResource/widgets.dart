import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Text("WELL SOME RANDOM APP") ,
    // Image.asset("assets/images/bg1.jpg",),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.deepOrange[300].withOpacity(0.4),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange[300]),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange[700].withOpacity(0.4)),
      )
  );
}

TextStyle textFieldSignInStyle(){
  return TextStyle(
    color: Colors.deepOrange[700],
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
}