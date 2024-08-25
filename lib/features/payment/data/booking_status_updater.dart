import 'package:cloud_firestore/cloud_firestore.dart';

class BookingStatusUpdater {
  Future<void> updatePaymentStatus(String bookingId) async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference collectionRef =
        _firebaseFirestore.collection('Bookings');
    await collectionRef.doc(bookingId).update({'status': 'Completed'});
  }
}
