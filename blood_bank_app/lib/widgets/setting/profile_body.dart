import 'package:blood_bank_app/style.dart';
import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'build_switchlist_tile.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  showDateTimePicker(context) async {
    final DateTime initDateTime = DateTime.now();
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: initDateTime,
      firstDate: DateTime(1900),
      lastDate: initDateTime,
    );
    if (newDate == null) return null;
    final pickedDateTime = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
    );
    // setDateTime(pickedDateTime);
    // setDateController(formatOnlyDate(pickedDateTime));
  }

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
              ),
            ),
            title: const Text(
              'تعديل البيانات الاساسية',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const BuildSwitchListTile(
            title: "متاح",
            subTitle: "الظهور في قائمة المتبرعين",
          ),
          const BuildSwitchListTile(
            title: "اضهار رقمي",
            subTitle: "سيظهر رقمك للجميع",
          ),
          const BuildSwitchListTile(
            title: "استخدام الموقع",
            subTitle: "تشغيل gbs",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: MyTextFormField(
              hint: 'تاريخ الميلاد',
              hintStyle: eHintStyle,
              isPassword: true,
              blurrBorderColor: eSecondColor,
              focusBorderColor: eSecondColor,
              suffixIcon: true,
              icon: const Icon(Icons.calendar_month),
              readOnly: true,
              onTap: () {
                print('object');
              },
            ),
          ),
        ],
      ),
    );
  }
}
