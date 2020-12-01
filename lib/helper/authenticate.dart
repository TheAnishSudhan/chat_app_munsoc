import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/Pages/signin.dart';
import 'package:chat_app_munsoc/Pages/signup.dart';
import 'package:chat_app_munsoc/main.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  /*void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      //Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()),);
      return SignIn(toggleView());
    }else{
    //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()),);
      return SignUp(toggleView());
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView());
    } else {
      return SignUp(toggleView());
    }
  }
}


