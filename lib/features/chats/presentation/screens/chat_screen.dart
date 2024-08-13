import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            print(await AuthLocalDataService.getUserName());
            print(await AuthLocalDataService.getUserId());
          },
          child: Text('Press'),
        ),
      ),
    );
  }
}
