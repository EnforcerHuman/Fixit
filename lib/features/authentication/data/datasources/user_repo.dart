import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';

class UserRepository {
  Future<void> storeUserData(UserModel user) async {
    final collectionref = FirebaseFirestore.instance.collection('users');
    try {
      collectionref.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
