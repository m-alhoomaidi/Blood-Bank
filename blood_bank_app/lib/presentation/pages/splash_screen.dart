import 'package:blood_bank_app/presentation/pages/home_page.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/widgets/common/dialog_lottie.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = "splash_screen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: const MyLottie(),
        splashIconSize: 250,
        backgroundColor: ColorManager.white,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        nextScreen: const HomePage());
  }
}
