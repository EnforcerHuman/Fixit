// // payment_screen.dart
// import 'package:fixit/features/payment/data/razor_pay_remote_data_source.dart';
// import 'package:fixit/features/payment/presentation/bloc/bloc/payment_bloc.dart';
// import 'package:fixit/features/payment/presentation/bloc/bloc/payment_event.dart';
// import 'package:fixit/features/payment/presentation/bloc/bloc/payment_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PaymentBloc(RazorpayService()),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Payment')),
//         body: Center(
//           child: BlocBuilder<PaymentBloc, PaymentState>(
//             builder: (context, state) {
//               if (state is PaymentProcessing) {
//                 return CircularProgressIndicator();
//               } else if (state is PaymentSuccessState) {
//                 return Text('Payment Successful: ${state.response.paymentId}');
//               } else if (state is PaymentErrorState) {
//                 return Text('Payment Error: ${state.response.message}');
//               }
//               return ElevatedButton(
//                 onPressed: () {
//                   // BlocProvider.of<PaymentBloc>(context).add(PaymentStarted());
//                 },
//                 child: Text('Start Payment'),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
