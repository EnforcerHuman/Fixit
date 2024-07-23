import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/common/onboarding/starting_screen.dart';
import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit/features/authentication/presentation/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:fixit/features/home/presentation/screens/splash_screen.dart';
import 'package:fixit/testing/testfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBIL2QGPyrbqyCXF9sCP_m0lrhvr6gK2oM",
          appId: "1:697886710494:android:773bddd5f8e39041c3004f",
          messagingSenderId: "697886710494",
          projectId: "fixit-1b8b8",
          storageBucket: "fixit-1b8b8.appspot.com"));
  initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => SignInBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
