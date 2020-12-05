import 'package:chat_app_munsoc/WidgetResource/widgets.dart';
import 'package:chat_app_munsoc/helper/constants.dart';
import 'package:chat_app_munsoc/services/database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomID;
  ChatScreen(this.chatRoomID);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageTEC = new TextEditingController();

  Stream chatMessageStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
    builder: (context, snapshot){
      return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
           return MessageTile(snapshot.data.documents[index].data()["message"],
               snapshot.data.documents[index].data()["sentBy"] == Constants.myName);
          }) : Container();
    },
    );

  }

  sendMessage() {

    if(messageTEC.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageTEC.text,
        "sentby" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addChatMessages(widget.chatRoomID, messageMap);
      messageTEC.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getChatMessages(widget.chatRoomID).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[800],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageTEC,
                          style:
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,),
                          /*TextStyle(
                              //color: Colors.deepOrange[700]
                              color: Colors.black54
                          ),*/
                          decoration: InputDecoration(
                            hintText: "Type Message",
                            hintStyle: TextStyle(
                                color: Colors.black54
                            ),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFE64A19),
                                  const Color(0xFFBF360C),
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
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSentByMe? 0:20, right: isSentByMe? 20:0),
    width: MediaQuery.of(context).size.width,
    alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isSentByMe ? [
          const Color(0xFFE64A19),
          const Color(0xFFBF360C),]
        : [
          const Color(0xFF000000),
          const Color(0xDD000000),]
          //color: Colors.
    ),
        borderRadius: isSentByMe ?
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23),
            ) :
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23),
            )
    ),
        child: Text(message, style: isSentByMe? (TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,)) : (TextStyle(
          color: Colors.deepOrange[700],
          fontWeight: FontWeight.bold,
          fontSize: 18,))
      ),
    ),);
  }
}
