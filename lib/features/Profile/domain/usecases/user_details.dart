import 'package:fixit/features/Profile/data/user_datasource.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';

class UserDetails {
  final UserDatasource userDatasource;

  UserDetails(this.userDatasource);
  Stream<UserModel> loadUserDetails() async* {
    String id = await AuthLocalDataService.getUserId();
    yield* userDatasource.getUser(id);
  }
}
