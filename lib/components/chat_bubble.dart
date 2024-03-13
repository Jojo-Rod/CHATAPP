import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isCurrentUser});
  final String message;
  final bool isCurrentUser;

   

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ?const Color.fromARGB(255, 168, 9, 196):Colors.grey[600],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical:5, horizontal: 25),
      child:Text(message, style: const TextStyle(color: Colors.white, fontSize: 17),),
    );
  }
}