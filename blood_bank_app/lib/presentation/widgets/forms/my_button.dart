import '../../resources/color_manageer.dart';
import '../../resources/font_manager.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.color = Colors.blue,
    required this.title,
    required this.onPressed,
    this.minWidth = 200,
    this.style = const TextStyle(
      fontSize: FontSize.s14,
      color: ColorManager.white,
      fontFamily: FontConstants.fontFamily,
    ),
  });
  final Color color;
  final double? minWidth;
  final String title;
  final VoidCallback onPressed;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: 42,
          child: Text(
            title,
            style: style,
          ),
        ),
      ),
    );
  }
}
