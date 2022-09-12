import 'package:flutter/material.dart';

class MyDropdownButtonFormField extends StatelessWidget {
  const MyDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.onChange,
    required this.items,
    this.icon,
    this.hint,
    this.focusBorderColor,
    this.blurrBorderColor,
    this.fillColor,
    this.raduis = 10,
  }) : super(key: key);

  final String? hint;
  final String? value;
  final Icon? icon;
  final Color? focusBorderColor, blurrBorderColor, fillColor;
  final List<String> items;
  final Function(String?)? onChange;
  final double raduis;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(
        hint ?? "Select an item",
      ),
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
              ),
            ),
          )
          .toList(),
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: icon ?? const Icon(Icons.menu),
        filled: (fillColor != null),
        fillColor: fillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(raduis),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blurrBorderColor ?? Colors.blue[800]!,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusBorderColor ?? Colors.green,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
