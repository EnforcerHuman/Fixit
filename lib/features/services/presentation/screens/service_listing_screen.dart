import 'package:fixit/features/services/presentation/bloc/services_bloc/services_bloc.dart';
import 'package:fixit/features/services/presentation/widgets/search_bar.dart';
import 'package:fixit/features/services/presentation/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceListingScreen extends StatelessWidget {
  const ServiceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(),
            SizedBox(height: 20),
            BlocBuilder<ServicesBloc, ServicesState>(
              builder: (context, state) {
                if (state is ServicesLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio:
                            3 / 2, // Adjust the aspect ratio as needed
                      ),
                      itemCount: state.services.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(
                          serviceName: state.services[index].name,
                          imageUrl: state.services[index].imageUrl,
                        );
                      },
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
