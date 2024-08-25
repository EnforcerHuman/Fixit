import 'package:flutter/material.dart';

class DropDownMenuFb1 extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Function(String) onSelected;
  const DropDownMenuFb1({
    this.color = Colors.white,
    this.icon = const Icon(
      Icons.more_vert,
      color: Colors.black,
    ),
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: color,
      icon: icon,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'price low to high',
          child: Text(
            'price low to high',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'experience',
          child: Text(
            'experience',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
