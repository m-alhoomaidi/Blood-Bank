import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    this.hint,
    this.icon,
    this.keyBoardType = TextInputType.text,
    this.onChange,
    this.validator,
    this.onSave,
    this.focusBorderColor,
    this.blurrBorderColor,
    this.fillColor,
    this.isPassword = false,
  }) : super(key: key);

  final TextInputType keyBoardType;
  final String? hint;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSave;
  final IconData? icon;
  final Color? focusBorderColor, blurrBorderColor, fillColor;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      validator: validator,
      obscureText: isPassword,
      onSaved: onSave,
      keyboardType: keyBoardType,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon!) : null,
        hintText: hint!,
        filled: (fillColor != null),
        fillColor: fillColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blurrBorderColor ?? Colors.blue[800]!,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusBorderColor ?? Colors.green,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
