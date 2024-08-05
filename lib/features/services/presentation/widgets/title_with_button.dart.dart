import 'package:fixit/common/common_widgets/button.dart';
import 'package:flutter/material.dart';

class TitleWithButtonWidget extends StatelessWidget {
  final String leadingText;
  final VoidCallback onTap;
  final String buttonText;
  const TitleWithButtonWidget(
      {super.key,
      required this.leadingText,
      required this.onTap,
      required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingText,
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              width: 100,
              child: RoundButton(title: buttonText, onPressed: onTap))
        ],
      ),
    );
  }
}
