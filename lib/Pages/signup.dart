import 'package:chat_app_munsoc/helper/helperfunction.dart';
import 'package:chat_app_munsoc/services/auth.dart';
import 'package:chat_app_munsoc/services/database.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/WidgetResource/widgets.dart';
import 'package:chat_app_munsoc/Pages/chathome.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethod authMethods = new AuthMethod();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController pwTEC = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){

      Map<String, String> userInfoMap = {
        "name" : userNameTEC.text,
        "email id" : emailTEC.text,
      };

      HelperFunctions.saveUserEmailSharedPreference(emailTEC.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTEC.text);

      setState(() {
        isLoading = true;
      });

      authMethods.signUpwithEmailAndPassword(emailTEC.text, pwTEC.text).then((val){
        //print("${val.userID}");

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatHome()
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator())
      ): SingleChildScrollView(
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
                  child:Column(
                   children: [
                    TextFormField(
                      validator: (val){
                        return val.isEmpty || val.length < 5 ? "Invalid: Username must be at 5 least characters long": null;
                      },
                      controller: userNameTEC,
                      style: textFieldSignInStyle(),
                      decoration: textFieldInputDecoration("username"),
                    ),
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
                  ],
                ),),

                SizedBox(height: 18,),
                GestureDetector(
                  onTap: (){
                    signMeUp();
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
                        "Have an account? Sign in",
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
