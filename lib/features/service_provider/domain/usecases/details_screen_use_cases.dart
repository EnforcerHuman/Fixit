import 'package:fixit/features/bookings/presentation/bloc/bookig_bloc/booking_bloc.dart';
import 'package:fixit/features/bookings/presentation/screens/location_screen.dart';
import 'package:fixit/features/service_provider/presentation/bloc/provider_details_bloc/provider_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderDetailsScreenUseCases {
  void handleBookButtonPress(
      BuildContext context, ProviderDetailsLoaded state) {
    context
        .read<BookingBloc>()
        .add(UpdateHourlyPayment(state.providerDetails['hourlyPay']));
    context
        .read<BookingBloc>()
        .add(UpdateServiceProviderId(state.providerDetails['id']));

    context
        .read<BookingBloc>()
        .add(UpdateServiceProviderName(state.providerDetails['name']));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LocationScreen(
          providerId: state.providerDetails['id'],
          latitude: state.providerDetails['location']['latitude'],
          longitude: state.providerDetails['location']['longitude'],
        ),
      ),
    );
  }
}
