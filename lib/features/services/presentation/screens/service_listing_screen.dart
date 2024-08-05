import 'package:fixit/features/services/presentation/bloc/services_bloc/services_bloc.dart';
import 'package:fixit/features/services/presentation/widgets/search_results_grid.dart';
import 'package:fixit/features/services/presentation/widgets/service_listing_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fixit/common/common_widgets/custom_search_bar.dart';
import 'package:fixit/features/services/presentation/bloc/service_search_bloc/service_search_bloc.dart';

class ServiceListingScreen extends StatelessWidget {
  const ServiceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              controller: searchController,
              hint: 'Search Services',
              onSearchChanged: (value) {
                context.read<ServiceSearchBloc>().add(SearchService(value!));
              },
              onIconPressed: () {},
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ServiceSearchBloc, ServiceSearchState>(
                builder: (context, searchState) {
                  if (searchState is ServiceSearchCompleted) {
                    return SearchResultsGrid(services: searchState.services);
                  } else if (searchState is ServiceSearchFailed) {
                    return const Center(child: Text('No services found'));
                  } else if (searchState is ServiceSearchError) {
                    return const Center(child: Text('Error: '));
                  } else {
                    return BlocBuilder<ServicesBloc, ServicesState>(
                      builder: (context, state) {
                        if (state is ServicesLoaded) {
                          return ServiceListingGrid(services: state.services);
                        } else if (state is ServicesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child: Text('No services available'));
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
