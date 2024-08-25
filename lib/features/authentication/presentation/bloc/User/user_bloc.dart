import 'package:bloc/bloc.dart';
import 'package:fixit/features/authentication/data/datasources/user_repo.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    UserRepository userRepo = UserRepository();
    // ignore: no_leading_underscores_for_local_identifiers
    UserModel _user = UserModel(
      email: '',
      id: '',
      name: '',
      phoneNumber: '',
      address: '',
      serviceHistory: [],
      isServiceProvider: false,
      preferences: {},
    );

    on<UserEvent>((event, emit) {});

    on<UpdateName>((event, emit) {
      _user = _user.copyWith(name: event.name);
    });
    on<UpdateEmail>((event, emit) {
      _user = _user.copyWith(email: event.email);
    });
    on<UpdatePhone>((event, emit) {
      _user = _user.copyWith(phoneNumber: event.phone);
    });
    on<UpdateUserId>((event, emit) {
      _user = _user.copyWith(id: event.userId);
    });
    on<SubmitUserDate>((event, emit) {
      try {
        userRepo.storeUserData(_user);
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
