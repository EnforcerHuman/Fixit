part of 'accepted_bookings_bloc.dart';

@immutable
sealed class AcceptedBookingsState {}

final class AcceptedBookingsInitial extends AcceptedBookingsState {}

class AcceptedBookingLoaded extends AcceptedBookingsState {
  final List<BookingModel> acceptedBookings;

  AcceptedBookingLoaded(this.acceptedBookings);
}

class AcceptedBookingError extends AcceptedBookingsState {}

class AcceptedBookingFailed extends AcceptedBookingsState {}
