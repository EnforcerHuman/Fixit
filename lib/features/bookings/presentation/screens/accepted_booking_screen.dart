// import 'package:fixit/core/config/api_config.dart';
// import 'package:fixit/features/bookings/presentation/bloc/accepted_bookings_bloc/accepted_bookings_bloc.dart';
// import 'package:fixit/features/bookings/presentation/widgets/accpted_booking_card.dart';
// import 'package:fixit/features/payment/data/payment_options_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UpcomingBookingsScreen extends StatelessWidget {
//   const UpcomingBookingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<AcceptedBookingsBloc>().add(GetAccceptedBooking());
//     return Scaffold(
//       body: BlocBuilder<AcceptedBookingsBloc, AcceptedBookingsState>(
//         builder: (context, state) {
//           print(state);
//           if (state is AcceptedBookingLoaded) {
//             if (state.acceptedBookings.isEmpty) {
//               return const Center(
//                 child: Text('NO BOOKINGS',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: state.acceptedBookings.length,
//                 itemBuilder: (context, index) {
//                   final booking = state.acceptedBookings[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: AccptedBookingCard(
//                         bookingId: state.acceptedBookings[index].id,
//                         onButtonPressed: () {},
//                         service: booking.serviceName,
//                         amount: double.tryParse(booking.hourlyPayment) ?? 99,
//                         bookingDate: booking.bookingDateTime,
//                         partnerName: booking.serviceName,
//                         isPaymentRequested: booking.totalPayment.isNotEmpty,
//                         razorPayOptions: PaymentOptions(
//                           key: ApiConfig.razorpayApi,
//                           amount: int.parse(booking.totalPayment) * 100,
//                           name: 'FIxit',
//                           description: 'payment for Service',
//                           prefill: {
//                             'contact': '8888888888',
//                             'email': 'fixit@example.com'
//                           },
//                           external: {
//                             'wallets': ['paytm']
//                           },
//                         )),
//                   );
//                 },
//               );
//             }
//           } else if (state is AcceptedBookingError) {
//             return const Center(child: Text('Error: "Unknown error"'));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

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
            return ErrorState();
          } else {
            return LoadingState();
          }
        },
      ),
    );
  }
}

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
                amount: int.parse(booking.totalPayment) * 100,
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
