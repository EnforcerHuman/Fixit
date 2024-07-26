import 'package:fixit/common/color_extension.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.,
      children: [
        Expanded(
            child: Container(
          height: 1,
          color: Tcolor.gray.withOpacity(0.5),
        )),
        Text(
          "  Or  ",
          style: TextStyle(color: Tcolor.black, fontSize: 12),
        ),
        Expanded(
            child: Container(
          height: 1,
          color: Tcolor.gray.withOpacity(0.5),
        )),
      ],
    );
  }
}
