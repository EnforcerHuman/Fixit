import 'package:fixit/features/service_provider/presentation/bloc/providers_by_location/providers_by_location_bloc.dart';
import 'package:fixit/features/service_provider/presentation/widgets/Provider_message.dart';
import 'package:fixit/features/service_provider/presentation/widgets/provider_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentLocationProviders extends StatelessWidget {
  final double latitude;
  final double longitude;

  const CurrentLocationProviders({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    context
        .read<ProvidersByLocationBloc>()
        .add(GetProviderByLocation(latitude, longitude));

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProvidersByLocationBloc, ProvidersByLocationState>(
          builder: (context, state) {
            if (state is ProvidersByLocationLoaded) {
              return ProviderGridWidget(providers: state.providers);
            } else {
              return const ProviderMessage(message: 'NO PROVIDER AVAILABLE');
            }
          },
        ),
      ),
    );
  }
}
