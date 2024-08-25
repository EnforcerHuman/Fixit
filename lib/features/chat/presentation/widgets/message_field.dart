import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final bool isSentByCurrentUser;
  final String message;
  final String time;
  const MessageField(
      {super.key,
      required this.isSentByCurrentUser,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSentByCurrentUser ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: isSentByCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: isSentByCurrentUser ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4), // Add some spacing between text and time
          Text(
            time, // Display the formatted time
            style: TextStyle(
              fontSize: 10,
              color: isSentByCurrentUser ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
