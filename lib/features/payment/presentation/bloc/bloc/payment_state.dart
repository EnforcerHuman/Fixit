import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentSuccessResponse response;
  PaymentSuccess(this.response);
}

class PaymentError extends PaymentState {
  final String errorMessage;
  PaymentError(this.errorMessage);
}
