import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/authentication/domain/usecase/handle_sign_in.dart';
import 'package:fixit/features/authentication/domain/usecase/validation_methods.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:fixit/features/authentication/presentation/widgets/Text_editing_field.dart';
import 'package:fixit/features/authentication/presentation/widgets/divider_widget.dart';
import 'package:fixit/features/authentication/presentation/widgets/forgot_password.dart';
import 'package:fixit/features/authentication/presentation/widgets/google_button.dart';
import 'package:fixit/features/authentication/presentation/widgets/new_user.dart';
import 'package:fixit/features/authentication/presentation/widgets/otp_sending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserCredential? user;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formkey = GlobalKey<FormState>();

    HandleAuthResultUseCase handleAuthResultUseCase =
        HandleAuthResultUseCaseImpl();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) async {
          if (state is SignInSuccess) {
            handleAuthResultUseCase.onSignInSuccess(
              context,
            );
          } else if (state is SignInError) {
            handleAuthResultUseCase.onSignInError(context, state.error);
          } else if (state is GoogleSignInError) {
            handleAuthResultUseCase.onGoogleSignInError(context, state.error);
          } else if (state is GoogleSignInSucess) {
            handleAuthResultUseCase.onGoogleSignInSuccess(context);
          }
        },
        builder: (context, state) {
          if (state is SignInProcessing) {
            return Center(
                child: Image.asset(
              "assets/img/loading.gif",
              key: const ValueKey("loading"),
            ));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Enter your email and password to login',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              TextEditingField(
                                controller: emailController,
                                hintText: 'enter email',
                                validation: ValidationMethods.validateEmail,
                                prefixIcon: const Icon(Icons.email),
                              ),
                              const SizedBox(height: 10),
                              TextEditingField(
                                prefixIcon: const Icon(Icons.lock),
                                controller: passwordController,
                                hintText: 'enter your password',
                                obscureText: true,
                                validation: ValidationMethods.validatePassword,
                              ),
                              ForgotPassword(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const ForgotPasswordScreen()))),
                              const SizedBox(height: 20),
                              RoundButton(
                                title: 'Sign In',
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(SignInUser(
                                        emailController.text,
                                        passwordController.text));
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              NewUser(onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => SignUpScreen()));
                              }),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.grey),
                                    width: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).width * 0.04,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const DividerWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    state is GoogleSignInProcessing
                        ? const OtpSending(message: 'Loging in')
                        : GoogleButton(onTap: () {
                            context.read<SignInBloc>().add(SignInWithGoogle());
                          })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
