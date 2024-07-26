import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/common/color_extension.dart';
import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/authentication/domain/usecase/handle_sign_in.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:fixit/features/authentication/presentation/widgets/otp_sending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UserCredential? user;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // GoogleAuth gauth = GoogleAuth();
    HandleAuthResultUseCase handleAuthResultUseCase =
        HandleAuthResultUseCaseImpl();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) async {
          if (state is SignInSuccess) {
            handleAuthResultUseCase.onSignInSuccess(context);
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
              key: ValueKey("loading"),
            ));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Enter your email and password to login',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: Icon(Icons.visibility_off),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle forgot password
                                },
                                child: const Text('Forgot Password?')
                                    .animate()
                                    .fade()
                                    .scale(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            RoundButton(
                              title: 'Sign In',
                              onPressed: () async {
                                context.read<SignInBloc>().add(SignInUser(
                                    emailController.text,
                                    passwordController.text));
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('New to fixit?'),
                                TextButton(
                                  onPressed: () {
                                    // Handle sign up
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => SignUpScreen()));
                                  },
                                  child: const Text('Sign up now'),
                                ),
                              ],
                            ),
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Tcolor.gray.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          "  Or  ",
                          style: TextStyle(color: Tcolor.black, fontSize: 12),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Tcolor.gray.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state is GoogleSignInProcessing
                        ? const OtpSending(message: 'Loging in')
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle Google sign in
                                  context
                                      .read<SignInBloc>()
                                      .add(SignInWithGoogle());
                                },
                                icon: Image.asset('assets/img/Google_logo.png'),
                                label: const Text('Google'),
                              ),
                            ],
                          ),
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
