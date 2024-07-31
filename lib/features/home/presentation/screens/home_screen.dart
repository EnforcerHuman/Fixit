import 'package:fixit/features/service_provider/presentation/screen/service_provider_details_screen.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:fixit/features/services/data/data_sources/service_remote_repository.dart';
import 'package:fixit/features/services/presentation/bloc/services_bloc/services_bloc.dart';
import 'package:fixit/features/services/presentation/widgets/popular_services.dart';
import 'package:fixit/features/services/presentation/widgets/search_bar.dart';
import 'package:fixit/features/services/presentation/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service_provider/presentation/bloc/bloc/service_provider_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ServiceProviderBloc>().add(GetServiceProvider());

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomSearchBar(),
            const SizedBox(
              height: 10,
            ),
            TitleWithButtonWidget(
                leadingText: 'Popular Services',
                onTap: () {},
                buttonText: 'View All'),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ServicesBloc, ServicesState>(
              builder: (context, state) {
                if (state is ServicesLoaded) {
                  return SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 130,
                        childAspectRatio: 0.35,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: state.services.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            width: 30,
                            margin: const EdgeInsets.all(8),
                            child: ServiceCard(
                              serviceName: state.services[index].name,
                              imageUrl: state.services[index].imageUrl,
                            ));
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TitleWithButtonWidget(
                leadingText: 'Service Providers',
                onTap: () {},
                buttonText: 'View All'),
            const SizedBox(height: 10),
            BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
                builder: (context, state) {
              if (state is ServiceProviderLoaded) {
                return SizedBox(
                  height: 245,
                  width: double.infinity,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 180,
                      childAspectRatio: 0.35,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: state.providers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          width: 30,
                          margin: const EdgeInsets.all(8),
                          child: ServiceProviderCard(
                              name: state.providers[index]['name'],
                              profession: state.providers[index]['serviceArea'],
                              imageUrl:
                                  state.providers[index]['profileImage'] ?? '',
                              rating: 2,
                              onDetailsPressed: () {
                                ServiceRemoteRepository
                                    serviceRemoteRepository =
                                    ServiceRemoteRepository();
                                serviceRemoteRepository.getServices();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        ServiceProviderProfile()));
                              }));
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ],
        ),
      ),
    );
  }
}
