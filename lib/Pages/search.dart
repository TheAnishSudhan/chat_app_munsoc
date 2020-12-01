import 'package:chat_app_munsoc/Pages/chatscreen.dart';
import 'package:chat_app_munsoc/WidgetResource/widgets.dart';
import 'package:chat_app_munsoc/helper/constants.dart';
import 'package:chat_app_munsoc/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_munsoc/helper/helperfunction.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTEC = new TextEditingController();

  QuerySnapshot searchSnapshot;
  initiateSearch(){
    databaseMethods
        .getUserByUsername(searchTEC.text)
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email id"],
          );
          }) : Container();
  }

  createChatroomAndStartConversation({String userName}){

    print("${Constants.myName}");
    if(userName != Constants.myName){
      String chatRoomID = getChatRoomID(userName, Constants.myName);
      List<String> users =  [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap={
        "users" : users,
        "chatRoomID" : chatRoomID,
      };
      DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatScreen()
      ));
    }else{
      print("Cannot send message to yourself");
    }

  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: textFieldSignInStyle(),),
              Text(userEmail, style: textFieldSignInStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatroomAndStartConversation(
                userName: userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message",style: textFieldSignInStyle(),),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {

    super.initState();
  }

  getUserInfo() async{
    _myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              //color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTEC,
                        style: TextStyle(
                          color: Colors.deepOrange[700]
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Username",
                          hintStyle: TextStyle(
                            color: Colors.grey[700]
                          ),
                          border: InputBorder.none,
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              //TODO const Color(value),
                              //TODO const Color(value),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        //TODO child: Image.asset("assets/images/somethng.png")
                      ),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomID(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}