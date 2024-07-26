import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/authentication/domain/usecase/handle_sign_up.dart';
import 'package:fixit/features/authentication/domain/usecase/handle_sign_up_result.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:fixit/features/authentication/presentation/widgets/divider_widget.dart';
import 'package:fixit/features/authentication/presentation/widgets/email_field.dart';
import 'package:fixit/features/authentication/presentation/widgets/google_button.dart';
import 'package:fixit/features/authentication/presentation/widgets/name_field.dart';
import 'package:fixit/features/authentication/presentation/widgets/otp_sending.dart';
import 'package:fixit/features/authentication/presentation/widgets/password_field.dart';
import 'package:fixit/features/authentication/presentation/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController namecontroller = TextEditingController();
    HandleSignUpResultCase handleSignUpResultCase = HandleSignUpResultCase();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    // GoogleAuth gauth = GoogleAuth();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is GoogleSignUpSuccess) {
            handleSignUpResultCase.onGoogleSignUpSuccess(context, state.user!);
          } else if (state is GoogleSignUpFailed) {
            handleSignUpResultCase.onGoogleSignUpFailed(
                context, state.errorMessage);
          } else if (state is OTPSentState) {
            handleSignUpResultCase.onOtpSent(context, state.verificationId,
                state.email, state.password, phonecontroller.text);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formkey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Animate(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Enter your email and password to Sign Up',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            NameField(
                              namecontroller: namecontroller,
                            ),
                            const SizedBox(height: 20),
                            PhoneNumberField(phonecontroller: phonecontroller),
                            const SizedBox(height: 25),
                            EmailField(emailcontroller: emailcontroller),
                            const SizedBox(height: 25),
                            PasswordField(
                                passwordcontroller: passwordcontroller),
                            const SizedBox(
                              height: 30,
                            ),
                            state is OtpSendingState
                                ? const OtpSending(
                                    message: 'OTP Sending......',
                                  )
                                : RoundButton(
                                    title: 'Sign Up',
                                    onPressed: () async {
                                      if (_formkey.currentState!.validate()) {
                                        onSignUpButtonPressed(
                                            context,
                                            namecontroller.text,
                                            emailcontroller.text,
                                            phonecontroller.text,
                                            passwordcontroller.text);
                                      }
                                    }),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Animate(effects: const [
                                  FadeEffect(),
                                  ScaleEffect()
                                ], child: const Text('Have an account ?')),
                                TextButton(
                                  onPressed: () {
                                    // Handle sign up
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  },
                                  child: const Text('Sign In now'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).width * 0.04,
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Column(
                    children: [
                      const DividerWidget(),
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(color: Colors.grey),
                            width: 20,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is GoogleSignUpLoading
                          ? const OtpSending(
                              message: 'Verifying......',
                            )
                          : GoogleButton(onTap: () {
                              context
                                  .read<SignUpBloc>()
                                  .add(GoogleVeification());
                            }),
                      const SizedBox(height: 30)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
