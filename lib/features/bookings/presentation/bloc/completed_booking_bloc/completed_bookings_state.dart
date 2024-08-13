part of 'completed_bookings_bloc.dart';

@immutable
sealed class CompletedBookingsState {}

final class CompletedBookingsInitial extends CompletedBookingsState {}

class CompletedBookingLoading extends CompletedBookingsState {}

class CompletedBookingLoaded extends CompletedBookingsState {
  final List<BookingModel> completedBooking;

  CompletedBookingLoaded(this.completedBooking);
}

class CompletedBookingError extends CompletedBookingsState {
  final String message;

  CompletedBookingError(this.message);
}
