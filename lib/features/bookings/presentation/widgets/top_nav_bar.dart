import 'package:fixit/common/color_extension.dart';
import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const TopNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Pending', 0),
            _buildNavItem('Accepted', 1),
            _buildNavItem('Completed', 2),
            _buildNavItem('cancelled', 3)
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return TextButton(
        onPressed: () => onItemTapped(index),
        child: Text(
          title,
          style: TextStyle(
              color: selectedIndex == index ? Tcolor.black : Tcolor.gray),
        ));
  }
}
