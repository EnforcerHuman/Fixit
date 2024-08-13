import 'package:fixit/features/bookings/presentation/bloc/completed_booking_bloc/completed_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/completed_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CompletedBookingsBloc>().add(GetCompletedBookings());
    return Scaffold(
      body: BlocBuilder<CompletedBookingsBloc, CompletedBookingsState>(
        builder: (context, state) {
          if (state is CompletedBookingLoaded) {
            if (state.completedBooking.isEmpty) {
              return const Center(
                child: Text(
                  'No bookings completed',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.completedBooking.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CompletedBookingCard(
                    service: state.completedBooking[index].serviceName,
                    amount: double.parse(
                      state.completedBooking[index].totalPayment,
                    ),
                    bookingDate: state.completedBooking[index].bookingDateTime,
                    partnerName:
                        state.completedBooking[index].serviceProviderName,
                    onButtonPressed: () {},
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
