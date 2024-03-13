
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main/chat/chat_service.dart';
import 'package:main/components/MyTextField.dart';
import 'package:main/components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});
  final String receiverUserEmail;
  final String receiverUserID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      //clear the controller fter sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(widget.receiverUserEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

// build message list
    Widget _buildMessageList(){
      return StreamBuilder(stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),builder: (context,snapshot){
        if (snapshot.hasError){
          return Text("Error : ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading......");
        }
        return ListView(
            children: snapshot.data!.docs.map((document) => _buildUserListItem(document)).toList(),
        );
      });
    }
// build message item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // isCurrentUser or not
    bool isCurrentUser = data['senderID'] == _firebaseAuth.currentUser!.uid;
    // align sender msg to right and receiver msg to left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
        return Container(
          alignment: alignment,
          child: Column(
            // crossAxisAlignment: (alignment)?CrossAxisAlignment.end:,
            children: [
              // Text(data['senderEmail'], style: const TextStyle(fontSize: 20),),
              // Container(
                ChatBubble(message:data["message"],isCurrentUser:isCurrentUser),
                // color: const Color.fromRGBO(45, 76, 235, 0),
                // child: Text(data['message'],style: const TextStyle(fontSize: 20))
                // ),
            ],
          )
        );
  }

// build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        // textfield
        Expanded(
          child: Card(
            color:Colors.white ,
            child: MyTextField(
                      controller: _messageController,
                      hintText: "Enter message",
                      obscureText: false,
                      suffixIcon: null,
                    ),
          ),
        ),
        // send button
        IconButton(
          color: Colors.grey,
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
            ))
      ],
    );
  }
}
