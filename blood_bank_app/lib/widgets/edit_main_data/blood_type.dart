import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/blood_types.dart';
import '../../shared/style.dart';
import '../forms/my_dropdown_button_form_field.dart';

class BloodType extends StatefulWidget {
  const BloodType({super.key});

  @override
  State<BloodType> createState() => _BloodTypeState();
}

class _BloodTypeState extends State<BloodType> {
  String? bloodType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          child: MyDropdownButtonFormField(
            hint: "فصيلة دمك",
            validator: (value) {
              return (value == null) ? 'يرجى اختيار فصيلة الدم' : null;
            },
            value: bloodType,
            hintColor: eTextColor,
            items: BloodTypes.bloodTypes,
            blurrBorderColor: Colors.white,
            focusBorderColor: eTextFieldFocusBorder,
            fillColor: eTextFieldFill,
            icon: const Icon(Icons.bloodtype_outlined),
            onChange: (value) => setState(() => bloodType = value),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
