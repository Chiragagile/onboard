import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/utils/assets.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/view/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackTextColor,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(Assets.appLogo,fit: BoxFit.contain,))
      ),
    );
  }
}
