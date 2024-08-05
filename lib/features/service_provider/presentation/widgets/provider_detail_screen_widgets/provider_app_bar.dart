import 'package:flutter/material.dart';

class ProviderAppBar extends StatelessWidget {
  final String imageUrl;
  final Size media;

  const ProviderAppBar(
      {super.key, required this.imageUrl, required this.media});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: media.width * 0.5,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
