import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset('assets/img/Fixit_logo.png'),
      title: Text(title ?? ''),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
