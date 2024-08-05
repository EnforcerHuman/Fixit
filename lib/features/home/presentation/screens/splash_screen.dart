import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:flutter/material.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';
import 'package:fixit/common/onboarding/starting_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedStatus();
  }

  Future<void> _checkLoggedStatus() async {
    isLogged = await AuthLocalDataService.getLoggedInstatus();
    if (isLogged) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => HomeScreen()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const StartingScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/img/large_logo.png')),
    );
  }
}
