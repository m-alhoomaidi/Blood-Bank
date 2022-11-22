import 'package:blood_bank_app/style.dart';
import 'package:flutter/material.dart';

class BuildSwitchListTile extends StatefulWidget {
  const BuildSwitchListTile({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  State<BuildSwitchListTile> createState() => _BuildSwitchListTileState();
}

class _BuildSwitchListTileState extends State<BuildSwitchListTile> {
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
        activeColor: ePrimColor,
        onChanged: (val) {
          setState(() {
            onchangValue = val;
          });
        },
      ),
    );
  }
}
