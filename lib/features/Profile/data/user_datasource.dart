import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';

class UserDatasource {
  Stream<UserModel> getUser(String id) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception('User not found');
      }
    });
  }
}
