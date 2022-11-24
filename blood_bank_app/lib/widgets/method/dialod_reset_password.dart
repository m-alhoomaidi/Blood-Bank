import 'dart:ffi';

import 'package:blood_bank_app/pages/home_page.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:flutter/material.dart';

class DialogResetPassWord {
  static Void? Dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("جاري التحقق "),
              content: const Text(
                "راجع الرسائل الواردة في بريدك الالكتروني يمكن ان تكون في قائمة المهملات او spam ومن ثم قم بتغير كلمة السر وسجل الدخول في التطبيق من جديد",
                style: TextStyle(height: 1.5),
              ),
              actions: <Widget>[
                MyButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  },
                  title: 'تم',
                ),
              ],
            ));
  }
}
