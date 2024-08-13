import 'package:cloud_firestore/cloud_firestore.dart';

class BookingStatusUpdater {
  Future<void> updatePaymentStatus(String bookingId) async {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionRef =
        _firebaseFirestore.collection('Bookings');
    await collectionRef.doc(bookingId).update({'status': 'Completed'});
  }
}
