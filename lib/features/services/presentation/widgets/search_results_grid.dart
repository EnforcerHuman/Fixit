import 'package:fixit/features/services/data/model/services_model.dart';
import 'package:fixit/features/services/presentation/widgets/services.dart';
import 'package:flutter/material.dart';

import 'package:fixit/features/service_provider/presentation/screen/profession_specific_provider_screen.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<ServicesModel> services;

  const SearchResultsGrid({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 2, // Adjust the aspect ratio as needed
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceCard(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ProfessionSpecificProviderScreen(
                profession: services[index].name,
              ),
            ));
          },
          serviceName: services[index].name,
          imageUrl: services[index].imageUrl,
        );
      },
    );
  }
}
