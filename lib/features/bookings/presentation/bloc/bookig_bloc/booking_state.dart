part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class BookingDataUpdated extends BookingState {}

class BookingDataUpdationFailed extends BookingState {}

class BookingDataUpdationError extends BookingState {}
