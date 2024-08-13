import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/bookings/domain/use_cases/booking_use_case.dart';
import 'package:meta/meta.dart';

import '../../../data/model/booking_model.dart';

part 'completed_bookings_event.dart';
part 'completed_bookings_state.dart';

class CompletedBookingsBloc
    extends Bloc<CompletedBookingsEvent, CompletedBookingsState> {
  final BookingUseCase bookingUseCase;
  CompletedBookingsBloc(this.bookingUseCase)
      : super(CompletedBookingsInitial()) {
    on<GetCompletedBookings>((event, emit) async {
      String userId = await AuthLocalDataService.getUserId();
      emit(CompletedBookingLoading());
      try {
        await emit.forEach<List<BookingModel>>(
            bookingUseCase.getCompltedBooking(userId),
            onData: (data) => CompletedBookingLoaded(data),
            onError: (error, stackTrace) =>
                CompletedBookingError(error.toString()));
      } catch (e) {
        emit(CompletedBookingError(e.toString()));
      }
    });
  }
}
