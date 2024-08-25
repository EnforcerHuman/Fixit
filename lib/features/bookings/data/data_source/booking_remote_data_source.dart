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
    } catch (e) {
      //handle exceptoin
    }
  }

  Stream<List<BookingModel>> getBookings(String userId) {
    return _firebaseFirestore
        .collection('Bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docSnapshot) {
        return BookingModel.fromMap(docSnapshot.data(), docSnapshot.id);
      }).toList();
    });
  }
}
