import 'package:blood_bank_app/core/check_active.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blood_bank_app/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/presentation/pages/home_page.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/widgets/common/dialog_lottie.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> c190121177ca54752925eb648e5a71454f0e30fb
=======
>>>>>>> c190121177ca54752925eb648e5a71454f0e30fb
=======
>>>>>>> c190121177ca54752925eb648e5a71454f0e30fb
import 'package:page_transition/page_transition.dart';
>>>>>>> c190121177ca54752925eb648e5a71454f0e30fb

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = "splash_screen";

  @override
  Widget build(BuildContext context) {
    CheckActive.checkActiveUser();

    return AnimatedSplashScreen(
        splash: const MyLottie(),
        splashIconSize: 250,
        backgroundColor: ColorManager.white,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        nextScreen: const HomePage());
  }
}
