import 'package:flutter/material.dart';

class MyDropdownButtonFormField extends StatefulWidget {
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
  }) : super(key: key);

  final String? hint;
  final String? value;
  final Icon? icon;
  final Color? focusBorderColor, blurrBorderColor, fillColor;
  final List<String> items;
  final Function(String?)? onChange;

  @override
  State<MyDropdownButtonFormField> createState() =>
      _MyDropdownButtonFormFieldState();
}

class _MyDropdownButtonFormFieldState extends State<MyDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(
        widget.hint ?? "Select an item",
      ),
      value: widget.value,
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
              ),
            ),
          )
          .toList(),
      onChanged: widget.onChange,
      decoration: InputDecoration(
        prefixIcon: widget.icon ?? const Icon(Icons.menu),
        filled: (widget.fillColor != null),
        fillColor: widget.fillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.blurrBorderColor ?? Colors.blue[800]!,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor ?? Colors.green,
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
