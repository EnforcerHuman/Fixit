import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_google_aauth_services.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    GoogleAuth gauth = GoogleAuth();
    PhoneAuthentication auth = PhoneAuthentication();
    on<SignUpEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SendOTPEvent>((event, emit) async {
//
      emit(OtpSendingState());
      try {
        String id = await auth.sendOTP(
          event.phone,
        );
        print('id from bloc $id');
        emit(OTPSentState(id, event.password, id, event.email));
      } catch (e) {
        emit(SignUpErrorState(''));
      }
    });

    on<VerifyOTPEvent>((event, emit) async {
      emit(OtpVerifyingState());
      try {
        UserCredential credential = await auth.verifyOTP(
            event.otp, event.verificationId, event.email, event.password);
        emit(SignUpSuccessState(credential));
      } catch (e) {
        emit(SignUpErrorState(e.toString()));
      }
    });

    on<GoogleVeification>((event, emit) async {
      emit(GoogleSignUpLoading());
      try {
        User? user = await gauth.signUpWithGoogle();
        if (user == null) {
          emit(GoogleSignUpFailed('User already exists'));
        } else {
          emit(GoogleSignUpSuccess(user));
        }
      } catch (e) {
        emit(GoogleSignUpFailed(e.toString()));
      }
    });
  }
}
