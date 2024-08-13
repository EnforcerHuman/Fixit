import 'package:fixit/features/bookings/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestedBookingScreen extends StatelessWidget {
  const RequestedBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Bookings'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
        builder: (context, state) {
          print(state);
          if (state is RequestedBookingLoaded) {
            return ListView.builder(
              itemCount: state.requestedBooking.length,
              itemBuilder: (context, index) {
                final booking = state.requestedBooking[index];

                double hourlyPayment =
                    double.tryParse(booking.hourlyPayment ?? '') ?? 99;

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BookingCard(
                    onButtonPressed: () {
                      print(booking.hourlyPayment);
                    },
                    service: booking.serviceName,
                    amount: hourlyPayment,
                    bookingDate: booking.bookingDateTime ?? 'No Date',
                    partnerName: booking.serviceProviderName,
                  ),
                );
              },
            );
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
