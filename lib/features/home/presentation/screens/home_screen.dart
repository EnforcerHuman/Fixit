import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/DB/db_functions.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // DbFunction db = DbFunction();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  AuthLocalDataService.setLoginStatus(false);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => LoginScreen()), (a) {
                    return true;
                  });
                },
                child: Text('Logout')),
            ElevatedButton(
                onPressed: () {
                  // db.getUserDetailsById(widget.userdetails.user!.uid);
                },
                child: Text('test'))
          ],
        ),
      ),
    );
  }
}
