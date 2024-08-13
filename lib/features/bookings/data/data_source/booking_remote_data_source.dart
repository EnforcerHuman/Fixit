import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/bookings/data/model/booking_model.dart';

class BookingRemotedataSource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> storeBookingDetails(BookingModel bookingModel) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentReference docref =
          await firestore.collection('Bookings').add(bookingModel.toMap());
      String id = docref.id;
      firestore.collection('Bookings').doc(id).update({'id': id});
      print("Booking details stored successfully");
    } catch (e) {
      print("Error storing booking details: $e");
    }
  }

  Stream<List<BookingModel>> getBookings(String userId) {
    print('User Id from Remote data source : *************');
    print(userId);
    return _firebaseFirestore
        .collection('Bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });
  }
}
