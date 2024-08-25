import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController messageController;
  final Function() onPressed;
  const MessageTextField(
      {super.key, required this.messageController, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(hintText: 'Enter message'),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: onPressed),
        ],
      ),
    );
  }
}
