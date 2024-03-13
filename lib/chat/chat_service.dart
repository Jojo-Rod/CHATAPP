import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/model/message.dart';

class ChatService extends ChangeNotifier{
  // get instance of firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MESSSAGE
  Future<void> sendMessage(String receiverID, String message) async{

    // get current user's info  
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();
    
    // create a new message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      timeStamp: timeStamp,
      message: message,
    );
    
    // create a chatroom id for the current user id and receiver id (sorted to ensure uniqueness)
     List<String> ids = [currentUserId, receiverID];
     ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair)
     String chatRoomID = ids.join("_"); //combine the ids into a single string to use as a chatRoomID
    
    // add new message to database
    await _firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').add(newMessage.toMap());
  }
  // GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID){
    // construct charoom id from user ids (sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timeStamp', descending: false).snapshots();
  }
}