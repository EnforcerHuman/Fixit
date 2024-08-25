import 'package:fixit/common/color_extension.dart';
import 'package:fixit/features/bookings/presentation/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const TopNavBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight < 80 ? 80 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      backgroundColor: Tcolor.primaryColor1.withOpacity(0.3),
      elevation: 1,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildNavItem(),
      ),
    );
  }

//Nav items widgets
  Widget _buildNavItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NavItem(
          title: 'Pending',
          index: 0,
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
          primaryColor: Tcolor.primaryColor1,
          blackColor: Tcolor.black,
          grayColor: Tcolor.gray,
        ),
        NavItem(
          title: 'Accepted',
          index: 1,
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
          primaryColor: Tcolor.primaryColor1,
          blackColor: Tcolor.black,
          grayColor: Tcolor.gray,
        ),
        NavItem(
          title: 'Completed',
          index: 2,
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
          primaryColor: Tcolor.primaryColor1,
          blackColor: Tcolor.black,
          grayColor: Tcolor.gray,
        ).animate(),
        // NavItem(
        //   title: 'Cancelled',
        //   index: 3,
        //   selectedIndex: selectedIndex,
        //   onItemTapped: onItemTapped,
        //   primaryColor: Tcolor.primaryColor1,
        //   blackColor: Tcolor.black,
        //   grayColor: Tcolor.gray,
        // ).animate()
      ],
    );
  }
}
