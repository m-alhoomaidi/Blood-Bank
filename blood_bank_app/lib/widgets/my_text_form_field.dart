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
    this.primaryColor,
    this.secondaryColor,
  }) : super(key: key);

  final TextInputType keyBoardType;
  final String? hint;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSave;
  final IconData? icon;
  final Color? primaryColor, secondaryColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      validator: validator,
      onSaved: onSave,
      keyboardType: keyBoardType,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon!) : null,
        hintText: hint!,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: secondaryColor ?? Colors.blue[800]!,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor ?? Colors.green,
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
