import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';
import 'package:fixit/features/bookings/domain/use_cases/booking_use_case.dart';
import 'package:meta/meta.dart';

part 'accepted_bookings_event.dart';
part 'accepted_bookings_state.dart';

class AcceptedBookingsBloc
    extends Bloc<AcceptedBookingsEvent, AcceptedBookingsState> {
  final BookingUseCase bookingUseCase;
  AcceptedBookingsBloc(this.bookingUseCase) : super(AcceptedBookingsInitial()) {
    on<GetAccceptedBooking>((event, emit) async {
      String userId = await AuthLocalDataService.getUserId();
      try {
        await emit.forEach<List<BookingModel>>(
          bookingUseCase.getAcceptedBooking(userId),
          onData: (data) {
            // Print each booking in the received list
            return AcceptedBookingLoaded(data);
          },
          onError: (error, stackTrace) {
            return AcceptedBookingError();
          },
        );
      } catch (e) {
        emit(AcceptedBookingError());
      }
    });
  }
}
