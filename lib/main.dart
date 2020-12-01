import 'package:chat_app_munsoc/Pages/chathome.dart';
import 'package:chat_app_munsoc/Pages/signup.dart';
import 'package:chat_app_munsoc/helper/helperfunction.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/helper/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn =  value;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange[700],
        scaffoldBackgroundColor: Colors.grey[850],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? ChatHome() : Authenticate(),
      // home: SignUp(),
    );
  }
}
