import '../../presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/home_page.dart';
import '../../presentation/widgets/forms/my_button.dart';

class DialogResetPassWord {
  static void resetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.resetPasswordDialogTitle),
        content: Text(
          AppStrings.resetPasswordDialogMessage,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: <Widget>[
          MyButton(
            onPressed: _moveToHomePage(context),
            title: AppStrings.resetPasswordDialogOkButton,
          ),
        ],
      ),
    );
  }

  static _moveToHomePage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
      ),
    );
  }
}
