import 'package:fixit/features/payment/data/payment_options_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class PaymentEvent {}

class MakePayment extends PaymentEvent {
  final PaymentOptions options;
  final String bookingid;
  MakePayment(this.options, this.bookingid);
}

class PaymentSuccessEvent extends PaymentEvent {
  final PaymentSuccessResponse response;
  PaymentSuccessEvent(this.response);
}

class PaymentErrorEvent extends PaymentEvent {
  final String errorMessage;
  PaymentErrorEvent(this.errorMessage);
}
