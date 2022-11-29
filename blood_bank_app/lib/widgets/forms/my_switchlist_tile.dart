import 'package:flutter/material.dart';

import 'package:blood_bank_app/style.dart';

class MySwitchListTile extends StatelessWidget {
  const MySwitchListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onChange,
    this.onchangValue = false,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final bool onchangValue;
  final ValueChanged<bool>? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
      child: SwitchListTile(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
            )),
        subtitle: Text(subTitle),
        value: onchangValue,
        activeColor: eSecondColor,
        onChanged: onChange,
      ),
    );
  }
}
