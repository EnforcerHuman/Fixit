import 'package:fixit/common/common_widgets/button.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';
import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:fixit/features/authentication/presentation/widgets/otp_sending.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String password;
  final String phone;
  final String email;
  const OtpScreen(
      {super.key,
      required this.verificationId,
      required this.password,
      required this.phone,
      required this.email});

  @override
  Widget build(BuildContext context) {
    print('verification id from otp screen : $verificationId');
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/Fixit_logo.png'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is SignUpSuccessState) {
            context
                .read<UserBloc>()
                .add(UpdateUserId(state.userCredential.user!.uid));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => HomeScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              children: [
                const Text(
                  'Enter 6-digit OTP code sent to your Phone Number',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 77, 77),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: controller,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: 'Enter your otp',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                state is OtpVerifyingState
                    ? const OtpSending(
                        message: 'Verifying....',
                      )
                    : RoundButton(
                        title: "Verify",
                        onPressed: () {
                          //OTP verification logic here
                          context.read<SignUpBloc>().add(VerifyOTPEvent(
                              controller.text,
                              verificationId,
                              email,
                              password));
                        }),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Did not receive code?'),
                    TextButton(
                        onPressed: () {
                          //logic to send otp again
                        },
                        child: Text('send again')),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
