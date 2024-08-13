part of 'completed_bookings_bloc.dart';

@immutable
sealed class CompletedBookingsEvent {}

class GetCompletedBookings extends CompletedBookingsEvent {}
