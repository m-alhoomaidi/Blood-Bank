import 'package:flutter/material.dart';

import '../../style.dart';
import '../forms/my_text_form_field.dart';
import 'build_switchlist_tile.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                )),
            title: const Text(
              'تعديل البيانات الاساسية',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            )),
        const BuildSwitchListTile(
            title: "متاح", subTitle: "الظهور في قائمة المتبرعين"),
        const BuildSwitchListTile(
            title: "اضهار رقمي", subTitle: "سيظهر رقمك للجميع"),
        const BuildSwitchListTile(
            title: "استخدام الموقع", subTitle: "تشغيل gbs"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
          child: TextFormField(
            onSaved: (val) {},
            onTap: () {},
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (_) {},
            decoration: InputDecoration(
              focusedBorder: null,
              suffixIcon: Icon(Icons.date_range_outlined),
              labelText: 'تاريخ الميلاد',
            ),
          ),
        ),
      ],
    ));
  }
}
