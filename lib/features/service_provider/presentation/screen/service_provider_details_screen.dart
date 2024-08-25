import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/service_provider/domain/usecases/details_screen_use_cases.dart';
import 'package:fixit/features/service_provider/presentation/bloc/bloc/provider_stats_bloc.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_detail_screen_widgets/bio_section.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_detail_screen_widgets/provider_app_bar.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_detail_screen_widgets/provider_info_section.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_detail_screen_widgets/provider_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixit/features/service_provider/presentation/bloc/provider_details_bloc/provider_details_bloc.dart';

class ServiceProviderDetailsScreen extends StatelessWidget {
  final String id;

  const ServiceProviderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ProviderDetailsScreenUseCases providerDetailsScreenUseCases =
        ProviderDetailsScreenUseCases();
    context.read<ProviderDetailsBloc>().add(GetProviderDetails(id));
    context.read<ProviderStatsBloc>().add(GetProviderStats(id));
    return Scaffold(
      body: BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
        builder: (context, state) {
          if (state is ProviderDetailsLoaded) {
            return _buildLoadedContent(
                context, state, providerDetailsScreenUseCases);
          } else if (state is ProviderDetailsError) {
            return const Center(child: Text('Some error occurred'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, ProviderDetailsLoaded state,
      ProviderDetailsScreenUseCases providerDetailsScreenUseCases) {
    var media = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        ProviderAppBar(
            imageUrl: state.providerDetails['profileImage'], media: media),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProviderInfoSection(
                            providerDetails: state.providerDetails),
                        const SizedBox(height: 16),
                        ProviderStatsSection(
                            providerDetails: state.providerDetails),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        BioSection(bio: state.providerDetails['info']),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: RoundButton(
                    title: 'Book',
                    onPressed: () => providerDetailsScreenUseCases
                        .handleBookButtonPress(context, state),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
