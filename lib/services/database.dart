import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async{
    return  await FirebaseFirestore.instance.collection("users")
        .where("name",isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async{
    return  await FirebaseFirestore.instance.collection("users")
        .where("email id",isEqualTo: userEmail)
        .get();
  }
  
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
        .add(userMap);
  }

  createChatRoom(String chatRoomID, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomID).set(chatRoomMap);
  }
}