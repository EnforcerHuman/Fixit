part of 'accepted_bookings_bloc.dart';

@immutable
sealed class AcceptedBookingsEvent {}

class GetAccceptedBooking extends AcceptedBookingsEvent {}
