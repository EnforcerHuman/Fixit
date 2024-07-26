import 'package:fixit/common/color_extension.dart';
import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_google_aauth_services.dart';
import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:fixit/features/authentication/presentation/screens/otp_screen.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:fixit/features/authentication/presentation/widgets/otp_sending.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';
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

    TextEditingController emailecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    GoogleAuth gauth = GoogleAuth();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is GoogleSignUpSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => HomeScreen()),
                (route) => false);
          } else if (state is GoogleSignUpFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is OTPSentState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => OtpScreen(
                      verificationId: state.verificationId,
                      email: state.email,
                      password: state.password,
                      phone: phonecontroller.text,
                    )));
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
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your name',
                                prefixIcon: Icon(Icons.person_2_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: phonecontroller,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty && value.length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone',
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 25),
                            TextFormField(
                              controller: emailecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 25),
                            TextFormField(
                              controller: passwordcontroller,
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 6) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: Icon(Icons.visibility_off),
                                border: OutlineInputBorder(),
                              ),
                            ),
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
                                        context.read<UserBloc>().add(
                                            UpdateName(namecontroller.text));
                                        context.read<UserBloc>().add(
                                            UpdateEmail(emailecontroller.text));
                                        context.read<UserBloc>().add(
                                            UpdatePhone(phonecontroller.text));
                                        context.read<UserBloc>().add(
                                            UpdateIsServiceProvider(false));
                                        context.read<SignUpBloc>().add(
                                            SendOTPEvent(
                                                phonecontroller.text,
                                                emailecontroller.text,
                                                passwordcontroller.text));
                                      }
                                    }),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Animate(
                                    effects: [FadeEffect(), ScaleEffect()],
                                    child: const Text('Have an account ?')),
                                TextButton(
                                  onPressed: () {
                                    // Handle sign up
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (ctx) => LoginScreen()),
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
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: Tcolor.gray.withOpacity(0.5),
                          )),
                          Text(
                            "  Or  ",
                            style: TextStyle(color: Tcolor.black, fontSize: 12),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: Tcolor.gray.withOpacity(0.5),
                          )),
                        ],
                      ),
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
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Handle Google sign in
                                    context
                                        .read<SignUpBloc>()
                                        .add(GoogleVeification());
                                  },
                                  icon:
                                      Image.asset('assets/img/Google_logo.png'),
                                  label: const Text('Google'),
                                ),
                              ],
                            ),
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
