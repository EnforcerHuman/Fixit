import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/bookings/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestedBookingScreen extends StatelessWidget {
  const RequestedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
    return Scaffold(
      body: BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
        builder: (context, state) {
          if (state is RequestedBookingLoaded) {
            if (state.requestedBooking.isEmpty) {
              return const Center(
                child: Text('NO BOOKINGS'),
              );
            } else {
              return _buildBookings(state);
            }
          } else if (state is RequestedBookingError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}

Widget _buildBookings(RequestedBookingLoaded state) {
  return ListView.builder(
    itemCount: state.requestedBooking.length,
    itemBuilder: (context, index) {
      final booking = state.requestedBooking[index];
      double hourlyPayment = double.tryParse(booking.hourlyPayment) ?? 99;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: BookingCard(
          onButtonPressed: () {},
          service: booking.serviceName,
          amount: hourlyPayment,
          bookingDate: booking.bookingDateTime,
          partnerName: booking.serviceProviderName,
        ),
      );
    },
  );
}

void onButtonPressed() {}

void showWaarning(BuildContext context, Function() onpressed) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to cancel the booking request'),
          actions: <Widget>[
            RoundButton(title: 'confirm', onPressed: onpressed)
          ],
        );
      });
}
