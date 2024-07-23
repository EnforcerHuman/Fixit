import 'package:fixit/Utils/onboarding_items.dart';
import 'package:fixit/common/color_extension.dart';
import 'package:fixit/common/common_widgets/onboarding_page.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:fixit/features/authentication/presentation/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      PageView.builder(
                        controller: controller,
                        itemCount: pageArr.length,
                        itemBuilder: (context, index) {
                          var pObj = pageArr[index];
                          return OnBoardingPage(pObj: pObj);
                        },
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.02,
                        right: constraints.maxWidth * 0.02,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(color: Tcolor.primaryColor1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: constraints.maxHeight * 0.05,
                        right: constraints.maxWidth * 0.05,
                        child: SizedBox(
                          width: constraints.maxWidth * 0.25,
                          height: constraints.maxWidth * 0.25,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.15,
                                height: constraints.maxWidth * 0.15,
                                child: CircularProgressIndicator(
                                  value: selectPage / (pageArr.length - 1),
                                  strokeWidth: 2,
                                  color: Tcolor.primaryColor1,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Tcolor.primaryColor1,
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth * 0.075),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: IconButton(
                                  onPressed: () {
                                    if (selectPage < pageArr.length - 1) {
                                      selectPage = selectPage + 1;
                                      controller.animateToPage(selectPage,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.bounceIn);
                                      controller.jumpToPage(selectPage);
                                      setState(() {});
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.navigate_next,
                                    color: Tcolor.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
