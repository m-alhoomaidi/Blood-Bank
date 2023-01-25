import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class MyLottie extends StatelessWidget {
  const MyLottie({super.key});

  @override
  Widget build(BuildContext context) {
    print("object");
    return SafeArea(
        child: Center(
      child: Lottie.asset(
        'assets/blood-donation.json',
        repeat: true,
        reverse: true,
        animate: true,
      ),
    ));
  }
}
