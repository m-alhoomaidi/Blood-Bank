import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/pages/edit_main_data_page.dart';
import 'package:blood_bank_app/pages/user_date_page.dart';
import 'package:blood_bank_app/shared/style.dart';
import 'package:blood_bank_app/widgets/forms/my_dropdown_button_form_field.dart';
import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../forms/my_switchlist_tile.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String? selectedGender;

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

  bool is_gps_on = false, is_shown_number = false, is_shown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
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
        onTap: () {
          Navigator.of(context).pushNamed(EditMainDataPage.routeName);
        },
      ),
      const MySwitchListTile(
        title: "متاح",
        subTitle: "الظهور في قائمة المتبرعين",
        onChange: null,
      ),
      const MySwitchListTile(
        title: "اضهار رقمي",
        subTitle: "سيظهر رقمك للجميع",
        onChange: null,
      ),
      const MySwitchListTile(
        title: "استخدام الموقع",
        subTitle: "تشغيل gbs",
        onChange: null,
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            children: [
              MyTextFormField(
                hint: 'تاريخ الميلاد',
                hintStyle: eHintStyle,
                suffixIcon: true,
                blurrBorderColor: Colors.grey,
                focusBorderColor: eSecondColor,
                icon: const Icon(
                  Icons.calendar_month,
                  color: eSecondColor,
                ),
                readOnly: true,
                onTap: () {
                  showDateTimePicker(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ))
    ]));
  }
}
