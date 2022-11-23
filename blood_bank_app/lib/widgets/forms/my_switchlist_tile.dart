import 'package:blood_bank_app/style.dart';
import 'package:flutter/material.dart';

class MySwitchListTile extends StatefulWidget {
  const MySwitchListTile({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  State<MySwitchListTile> createState() => _MySwitchListTileState();
}

class _MySwitchListTileState extends State<MySwitchListTile> {
  bool onchangValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
      child: SwitchListTile(
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.title,
            )),
        subtitle: Text(widget.subTitle),
        value: onchangValue,
        activeColor: eSecondColor,
        onChanged: (val) {
          setState(() {
            onchangValue = val;
          });
        },
      ),
    );
  }
}
