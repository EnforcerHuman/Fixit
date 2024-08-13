import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_google_aauth_services.dart';
import 'package:fixit/features/authentication/domain/usecase/sign_in_use_case.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    GoogleAuth gauth = GoogleAuth();
    // PhoneAuthentication auth = PhoneAuthentication();

    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignInUser>((event, emit) async {
      SignInUseCase signnInUseCase = SignInUseCase();

      emit(SignInProcessing());
      try {
        UserCredential userCredential =
            await signnInUseCase.signIn(event.email, event.password);
        print('Print form user sign in bloc');
        print(userCredential.user?.uid);
        // AuthLocalDataService.setUserName(
        //     userCredential.user?.displayName ?? 'Test name');
        AuthLocalDataService.setUserKey(userCredential.user!.uid);
        bool isServiceProvider =
            await signnInUseCase.handleSignInSuccesss(userCredential);
        if (isServiceProvider == false) {
          emit(SignInSuccess(isServiceProvider));
        } else {
          emit(SignInError('User not found or not valid'));
        }
      } catch (e) {
        emit(SignInError(e.toString()));
      }
    });

    on<SignInWithGoogle>((event, emit) async {
      emit(GoogleSignInProcessing());
      try {
        await gauth.loginWithGoogle();
        emit(GoogleSignInSucess());
      } catch (e) {
        emit(GoogleSignInError(e.toString()));
      }
    });
    //
  }
}
