import 'package:bloc/bloc.dart';
import 'package:fixit/features/Profile/domain/usecases/user_details.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetails userDetails;
  UserDetailsBloc(this.userDetails) : super(UserDetailsInitial()) {
    on<LoadUserDetails>((event, emit) async {
      try {
        await emit.forEach<UserModel>(
          userDetails.loadUserDetails(),
          onData: (data) => UserDetailsLoaded(data),
          onError: (error, stackTrace) {
            return UserDetailsError(error.toString());
          },
        );
      } catch (e) {
        emit(UserDetailsError(e.toString()));
      }
    });
  }
}
