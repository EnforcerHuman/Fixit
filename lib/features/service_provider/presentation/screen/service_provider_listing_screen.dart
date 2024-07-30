import 'package:fixit/features/service_provider/presentation/bloc/bloc/service_provider_bloc.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceProviderListingScreen extends StatelessWidget {
  const ServiceProviderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the event to load service providers
    context.read<ServiceProviderBloc>().add(GetServiceProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Providers'),
      ),
      body: SafeArea(
        child: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
          builder: (context, state) {
            print('STATE IS $state');
            if (state is ServiceProviderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceProviderLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio:
                      0.75, // Adjust this to change the card height
                ),
                itemCount:
                    state.providers.length, // Use length of the providers list
                itemBuilder: (context, index) {
                  return ServiceProviderCard(
                    name: state.providers[index]['name'],
                    profession: "Profession $index",
                    imageUrl: state.providers[index]['profileImage'] ??
                        "https://via.placeholder.com/150",
                    rating: state.providers[index]['rating'] ?? 4,
                    onDetailsPressed: () {
                      // Add  details pressed logic here later
                    },
                  );
                },
              );
            } else if (state is ServiceProviderError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
