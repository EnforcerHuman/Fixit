// import 'package:fixit/features/payment/data/razor_pay_remote_data_source.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class RazorpayUseCase {
//   // Define the method to handle payment success
//   void onPaymentSuccess(PaymentSuccessResponse response) {
//     // Implement the logic to handle payment success
//     print('Payment Success: ${response.paymentId}');
//   }

//   void onPaymentError(PaymentFailureResponse response) {
//     // Implement the logic to handle payment error
//     print('Payment Error: ${response.message}');
//   }

//   void onExternalWallet(ExternalWalletResponse response) {
//     // Implement the logic to handle external wallet response
//     print('External Wallet: ${response.walletName}');
//   }

//   late RazorpayService _razorpay;

//   RazorpayUseCase() {
//     // Initialize RazorpayService with proper method references
//     _razorpay = RazorpayService(
//       onPaymentSuccess: (response) => onPaymentSuccess(response),
//       onPaymentError: (response) => onPaymentError(response),
//       onExternalWallet: (response) => onExternalWallet(response),
//     );
//   }

//   void executePayment(Map<String, dynamic> options) {
//     _razorpay.openCheckout(options);
//     // You might want to use a callback or stream to handle the results
//   }
// }
