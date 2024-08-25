import 'package:fixit/common/common_widgets/custom_search_bar.dart';
import 'package:fixit/features/service_provider/presentation/bloc/search_bloc/service_provider_search_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/service_provider_sorting_bloc/service_provider_sorting_bloc.dart';
import 'package:fixit/features/service_provider/presentation/screen/search_by_location_screen.dart';
import 'package:fixit/features/service_provider/presentation/screen/service_provider_details_screen.dart';
import 'package:fixit/features/service_provider/presentation/widgets/drop_down.dart';
import 'package:fixit/features/service_provider/presentation/widgets/service_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceProviderListingScreen extends StatelessWidget {
  const ServiceProviderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    context.read<ServiceProviderBloc>().add(GetServiceProvider());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context, searchController),
            Expanded(child: _buildBasedOnState()),
          ],
        ),
      ),
    );
  }

  Widget _buildBasedOnState() {
    return BlocBuilder<ServiceProviderSearchBloc, ServiceProviderSearchState>(
      builder: (context, searchState) {
        if (searchState is SearchCompleted) {
          if (searchState.providers.isEmpty) {
            return const Center(
              child: Text('NO RESULTS'),
            );
          } else {
            return _buildSearchResults(searchState);
          }
        } else if (searchState is SearchError) {
          return _buildError('Search Error ');
        } else {
          return _buildServiceProvidersList();
        }
      },
    );
  }

  Widget _buildSearchBar(
      BuildContext context, TextEditingController searchController) {
    return CustomSearchBar(
      controller: searchController,
      hint: 'Search Skilled workers',
      onSearchChanged: (value) {
        context
            .read<ServiceProviderSearchBloc>()
            .add(ServiceProviderSearch(value!));
      },
      onIconPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const SearchByLocationScreen()),
        );
      },
    );
  }

  Widget _buildSearchResults(SearchCompleted searchState) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: searchState.providers.length,
      itemBuilder: (context, index) {
        final provider = searchState.providers[index];
        return ServiceProviderCard(
          name: provider['name'],
          profession: provider['serviceArea'],
          imageUrl:
              provider['profileImage'] ?? "https://via.placeholder.com/150",
          rating: provider['rating'] ?? 4,
          onDetailsPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    ServiceProviderDetailsScreen(id: provider['id']),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildError(String message) {
    return Center(child: Text(message));
  }

  Widget _buildServiceProvidersList() {
    return BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
      builder: (context, state) {
        if (state is ServiceProviderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ServiceProviderLoaded) {
          return _buildProvidersGrid(state);
        } else if (state is ServiceProviderError) {
          return _buildError('Error: ${state.error}');
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  Widget _buildProvidersGrid(ServiceProviderLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: state.providers.length,
      itemBuilder: (context, index) {
        final provider = state.providers[index];
        return ServiceProviderCard(
          name: provider['name'],
          profession: provider['serviceArea'],
          imageUrl:
              provider['profileImage'] ?? "https://via.placeholder.com/150",
          rating: provider['rating'] ?? 4,
          onDetailsPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    ServiceProviderDetailsScreen(id: provider['id']),
              ),
            );
          },
        );
      },
    );
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceProviderSearchBloc, ServiceProviderSearchState>(
      builder: (context, searchState) {
        return BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
          builder: (context, serviceProviderState) {
            // Combine or use the states as needed
            return Align(
              alignment: Alignment.topRight,
              child: DropDownMenuFb1(
                onSelected: (String value) {
                  if (searchState is SearchCompleted) {
                  } else if (serviceProviderState is ServiceProviderLoaded) {
                    if (searchState is SearchCompleted) {
                      context.read<ServiceProviderSortingBloc>().add(
                          ServiceProviderSortRequested(
                              'price low to high', searchState.providers));
                    }
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
