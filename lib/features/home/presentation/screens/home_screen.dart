import 'package:fixit/common/common_widgets/cutom_app_bar.dart';
import 'package:fixit/features/home/presentation/widgets/welcome_widget.dart';
import 'package:fixit/features/services/presentation/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:fixit/features/services/presentation/bloc/services_bloc/services_bloc.dart';
import 'package:fixit/features/services/presentation/widgets/title_with_button.dart.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:fixit/features/home/domain/usecases/home_screen_use_cases.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenUseCases useCases = HomeScreenUseCases();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WelcomeWidget(),
            const SizedBox(height: 10),
            _buildPopularServices(context),
            const SizedBox(height: 10),
            _buildServiceProviders(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularServices(BuildContext context) {
    return Column(
      children: [
        TitleWithButtonWidget(
          leadingText: 'Popular Services',
          onTap: () => useCases.navigateToServiceListing(context),
          buttonText: 'View All',
        ),
        const SizedBox(height: 10),
        BlocBuilder<ServicesBloc, ServicesState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              return _buildServicesGrid(context, state);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context, ServicesLoaded state) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 130,
          childAspectRatio: 0.35,
          crossAxisSpacing: 7,
          mainAxisSpacing: 5,
        ),
        itemCount: state.services.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ServiceCard(
          onTap: () => useCases.navigateToProfessionSpecificProvider(
              context, state.services[index].name),
          serviceName: state.services[index].name,
          imageUrl: state.services[index].imageUrl,
        ),
      ),
    );
  }

  Widget _buildServiceProviders(BuildContext context) {
    return Column(
      children: [
        TitleWithButtonWidget(
          leadingText: 'Service Providers',
          onTap: () => useCases.navigateToServiceProviderListing(context),
          buttonText: 'View All',
        ),
        const SizedBox(height: 10),
        BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
          builder: (context, state) {
            if (state is ServiceProviderLoaded) {
              return _buildServiceProviderGrid(context, state);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  Widget _buildServiceProviderGrid(
      BuildContext context, ServiceProviderLoaded state) {
    return SizedBox(
      height: 245,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 180,
          childAspectRatio: 0.35,
          crossAxisSpacing: 7,
          mainAxisSpacing: 5,
        ),
        itemCount: state.providers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ServiceProviderCard(
          name: state.providers[index]['name'],
          profession: state.providers[index]['serviceArea'],
          imageUrl: state.providers[index]['profileImage'] ?? '',
          rating: 2,
          onDetailsPressed: () => useCases.navigateToProviderDetails(
              context, state.providers[index]['id']),
        ),
      ),
    );
  }
}
