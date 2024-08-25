import 'package:fixit/features/bookings/data/data_source/booking_remote_data_source.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';

class BookingUseCase {
  BookingRemotedataSource bookingRemotedataSource = BookingRemotedataSource();

  Stream<List<BookingModel>> getPendingBooking(String userId) {
    return bookingRemotedataSource.getBookings(userId).map((bookings) {
      return bookings
          .where((booking) => booking.status == 'Requested')
          .toList();
    });
  }

  Stream<List<BookingModel>> getAcceptedBooking(String userId) {
    return bookingRemotedataSource.getBookings(userId).map((bookings) {
      return bookings.where((booking) => booking.status == 'Accepted').toList();
    });
  }

  Stream<List<BookingModel>> getRejectedBookings(String userId) {
    return bookingRemotedataSource.getBookings(userId).map((bookings) {
      return bookings.where((booking) => booking.status == 'Rejected').toList();
    });
  }

  Stream<List<BookingModel>> getCompltedBooking(String userId) {
    return bookingRemotedataSource.getBookings(userId).map((bookings) {
      return bookings
          .where((booking) => booking.status == 'Completed')
          .toList();
    });
  }
}
