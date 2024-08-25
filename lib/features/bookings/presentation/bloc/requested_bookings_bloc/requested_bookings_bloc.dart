import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';
import 'package:fixit/features/bookings/domain/use_cases/booking_use_case.dart';
import 'package:meta/meta.dart';

part 'requested_bookings_event.dart';
part 'requested_bookings_state.dart';

class RequestedBookingsBloc
    extends Bloc<RequestedBookingsEvent, RequestedBookingsState> {
  final BookingUseCase bookingUseCase;
  RequestedBookingsBloc(this.bookingUseCase)
      : super(RequestedBookingsInitial()) {
    on<GetRequestedBooking>((event, emit) async {
      // Handle the getrequested booking event
      String userId = await AuthLocalDataService.getUserId();

      try {
        await emit.forEach<List<BookingModel>>(
          bookingUseCase.getPendingBooking(userId),
          onData: (data) {
            return RequestedBookingLoaded(data);
          },
          onError: (error, stackTrace) {
            return RequestedBookingError(error.toString());
          },
        );
      } catch (e) {
        emit(RequestedBookingError(e.toString()));
      }
    });
  }
}
