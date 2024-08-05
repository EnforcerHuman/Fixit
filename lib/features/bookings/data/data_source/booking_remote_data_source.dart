import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';

class BookingRemotedataSource {
  Future<void> storeBookingDetails(BookingModel bookingModel) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Bookings').add(bookingModel.toMap());
      print("Booking details stored successfully");
    } catch (e) {
      print("Error storing booking details: $e");
    }
  }
}
