import 'package:chat_app_munsoc/Pages/search.dart';
import 'package:chat_app_munsoc/helper/constants.dart';
import 'package:chat_app_munsoc/helper/helperfunction.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/services/auth.dart';
import 'package:chat_app_munsoc/helper/authenticate.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {

  AuthMethod authMethods =  new AuthMethod();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO title: Image.asset("", height: 50,),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()
              ));
        },
      ),
    );
  }
}
