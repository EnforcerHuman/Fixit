import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NavItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Color primaryColor;
  final Color blackColor;
  final Color grayColor;

  const NavItem({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.primaryColor,
    required this.blackColor,
    required this.grayColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedIndex == index;

    return TextButton(
      onPressed: () => onItemTapped(index),
      child: AnimatedContainer(
        height: 50,
        width: 80,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(milliseconds: 300),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isSelected ? blackColor : grayColor,
            ),
          ),
        ),
      ).animate().fadeIn().scale(
            duration: 300.ms,
            curve: Curves.decelerate,
          ),
    );
  }
}
