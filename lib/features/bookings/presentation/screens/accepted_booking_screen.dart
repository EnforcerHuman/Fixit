import 'package:fixit/core/config/api_config.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';
import 'package:fixit/features/bookings/presentation/bloc/accepted_bookings_bloc/accepted_bookings_bloc.dart';
import 'package:fixit/features/bookings/presentation/widgets/accpted_booking_card.dart';
import 'package:fixit/features/payment/data/payment_options_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingBookingsScreen extends StatelessWidget {
  const UpcomingBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AcceptedBookingsBloc>().add(GetAccceptedBooking());

    return Scaffold(
      body: BlocBuilder<AcceptedBookingsBloc, AcceptedBookingsState>(
        builder: (context, state) {
          if (state is AcceptedBookingLoaded) {
            return BookingList(acceptedBookings: state.acceptedBookings);
          } else if (state is AcceptedBookingError) {
            return const ErrorState();
          } else {
            return const LoadingState();
          }
        },
      ),
    );
  }
}

// class BookingList extends StatelessWidget {
//   final List<BookingModel> acceptedBookings;

//   const BookingList({required this.acceptedBookings, super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (acceptedBookings.isEmpty) {
//       return const EmptyBookings();
//     } else {
//       return ListView.builder(
//         itemCount: acceptedBookings.length,
//         itemBuilder: (context, index) {
//           final booking = acceptedBookings[index];
//           int test = booking.totalPayment.isNotEmpty
//               ? (int.tryParse(booking.totalPayment) ?? 0) * 100
//               : 0;
//           print('amount to be paid');
//           print(test);
//           return Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: AccptedBookingCard(
//               bookingId: booking.id,
//               onButtonPressed: () {
//                 // Define action for button press if needed
//               },
//               service: booking.serviceName,
//               amount: double.tryParse(booking.hourlyPayment) ?? 99,
//               bookingDate: booking.bookingDateTime,
//               partnerName: booking.serviceName,
//               isPaymentRequested: booking.totalPayment.isNotEmpty,
//               razorPayOptions: PaymentOptions(
//                 key: ApiConfig.razorpayApi,
//                 amount: int.parse(booking.totalPayment) * 100,
//                 name: 'Fixit',
//                 description: 'Payment for Service',
//                 prefill: {
//                   'contact': '8888888888',
//                   'email': 'fixit@example.com',
//                 },
//                 external: {
//                   'wallets': ['paytm'],
//                 },
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }
// }

class BookingList extends StatelessWidget {
  final List<BookingModel> acceptedBookings;

  const BookingList({required this.acceptedBookings, super.key});

  @override
  Widget build(BuildContext context) {
    if (acceptedBookings.isEmpty) {
      return const EmptyBookings();
    } else {
      return ListView.builder(
        itemCount: acceptedBookings.length,
        itemBuilder: (context, index) {
          final booking = acceptedBookings[index];

          int amountToBePaid = 0;
          try {
            amountToBePaid = booking.totalPayment.isNotEmpty
                ? (int.parse(booking.totalPayment)) * 100
                : 0;
          } catch (e) {
            // Handle the error, log it, or set a default value
            amountToBePaid = 0; // Default to 0 if parsing fails
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AccptedBookingCard(
              bookingId: booking.id,
              onButtonPressed: () {
                // Define action for button press if needed
              },
              service: booking.serviceName,
              amount: double.tryParse(booking.hourlyPayment) ?? 99,
              bookingDate: booking.bookingDateTime,
              partnerName: booking.serviceName,
              isPaymentRequested: booking.totalPayment.isNotEmpty,
              razorPayOptions: PaymentOptions(
                key: ApiConfig.razorpayApi,
                amount: amountToBePaid,
                name: 'Fixit',
                description: 'Payment for Service',
                prefill: {
                  'contact': '8888888888',
                  'email': 'fixit@example.com',
                },
                external: {
                  'wallets': ['paytm'],
                },
              ),
            ),
          );
        },
      );
    }
  }
}

class EmptyBookings extends StatelessWidget {
  const EmptyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Bookings',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error: "Unknown error"'),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
