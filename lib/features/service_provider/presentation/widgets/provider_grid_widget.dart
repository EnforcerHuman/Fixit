import 'package:fixit/features/service_provider/presentation/screen/service_provider_details_screen.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:flutter/material.dart';

class ProviderGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> providers;
  const ProviderGridWidget({super.key, required this.providers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];
        return ServiceProviderCard(
          name: provider['name'],
          profession: provider['serviceArea'],
          imageUrl:
              provider['profileImage'] ?? "https://via.placeholder.com/150",
          rating: provider['rating'] ?? 4,
          onDetailsPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ServiceProviderDetailsScreen(
                id: provider['id'],
              ),
            ));
          },
        );
      },
    );
  }
}
