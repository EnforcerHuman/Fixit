import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(milliseconds: 1500), // Adjust the speed of the effect
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 10,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
            Container(
              width: 60,
              height: 10,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
          ],
        ),
      ),
    );
  }
}
