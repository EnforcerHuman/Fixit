import 'package:fixit/common/color_extension.dart';
import 'package:fixit/common/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: Container(
        height: media.height,
        width: media.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: Tcolor.secondryGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/img/large_logo.png'),
            // Text(
            //   'Fixit',
            //   style: TextStyle(
            //       color: Tcolor.black,
            //       fontSize: 45,
            //       fontWeight: FontWeight.w700),
            // ),
            const Spacer(),
            SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ElevatedButton(
                      child: Text('Get started'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OnBoardingScreen()));
                      })),
            )
          ],
        ),
      ),
    );
  }
}
