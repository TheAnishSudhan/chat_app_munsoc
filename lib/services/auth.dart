import 'file:///D:/Media_Files_Library/Desktop/CODE_PROJECTS/Android_Studio_Projects/MUNSOC/chat_app_munsoc/lib/User/appUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod
{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  appUser  _userFromFirebaseUser(User user)
  {
    return user!=null ?   appUser(userId: user.uid) : null;
  }
  Future signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e)
    {
      print(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(String email, String pw) async{

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e){
      print(e.toString());
    }
  }

  Future resetPW(String email) async{

    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e){
      print(e.toString());
    }
  }

  Future signOut() async{

    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}