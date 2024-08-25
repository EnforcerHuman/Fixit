import 'package:fixit/features/payment/data/booking_status_updater.dart';
import 'package:fixit/features/payment/data/razor_pay_remote_data_source.dart';
import 'package:fixit/features/payment/presentation/bloc/bloc/payment_event.dart';
import 'package:fixit/features/payment/presentation/bloc/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final RazorpayService razorpayService;

  PaymentBloc(this.razorpayService) : super(PaymentInitial()) {
    String bookingId = '';
    razorpayService.onPaymentSuccess = (response) {
      add(PaymentSuccessEvent(response));
    };
    razorpayService.onPaymentError = (response) {
      add(PaymentErrorEvent(response.message.toString()));
    };

    on<MakePayment>((event, emit) {
      bookingId = event.bookingid;
      try {
        razorpayService.openCheckout(event.options);
      } catch (e) {
        emit(PaymentError(e.toString()));
      }
    });

    on<PaymentSuccessEvent>((event, emit) async {
      BookingStatusUpdater bookingStatusUpdater = BookingStatusUpdater();
      await bookingStatusUpdater.updatePaymentStatus(bookingId);
      emit(PaymentSuccess(event.response));
    });

    on<PaymentErrorEvent>((event, emit) {
      emit(PaymentError(event.errorMessage));
    });
  }
}
