import 'package:chat_app_munsoc/helper/helperfunction.dart';
import 'package:chat_app_munsoc/services/auth.dart';
import 'package:chat_app_munsoc/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/WidgetResource/widgets.dart';

import 'chathome.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController pwTEC = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState.validate()){

      HelperFunctions.saveUserEmailSharedPreference(emailTEC.text);
      //HelperFunctions.saveUserNameSharedPreference(userNameTEC.text);

      databaseMethods.getUserByUserEmail(emailTEC.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
      });

      setState(() {
        isLoading =  true;
      });

      authMethod.signInWithEmailAndPassword(emailTEC.text, pwTEC.text).then((val){
        if(val != null){

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatHome()
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -20,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                      validator: (val){
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                        ).hasMatch(val) ? null : "Please provide a valid email id";
                      },
                      controller: emailTEC,
                      style: textFieldSignInStyle(),
                      decoration: textFieldInputDecoration("email id"),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val){
                        return val.length >=5 ? null : "Please provide a password with at least 6 characters";
                      },
                      controller: pwTEC,
                      style: textFieldSignInStyle(),
                      decoration: textFieldInputDecoration("password"),
                    ),
                  ],),
                ),
                SizedBox(height: 18,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Forgot Password",
                      style: textFieldSignInStyle(),
                  ),
                ),
                SizedBox(height: 18,),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                       colors: [
                         const Color(0xFFE64A19),
                         const Color(0xFFBF360C),
                       ],
                      ),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text(
                      "Sign in",
                        style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 18,),
                GestureDetector(
                  onTap: (){
                    widget.toggle();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFE64A19),
                            const Color(0xFFBF360C),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
