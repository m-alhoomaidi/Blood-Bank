import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blood_bank_app/domain/entities/donor.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';
import '../../pages/edit_main_data_page.dart';
import '../../pages/setting_page.dart';
import '../../presentation/resources/color_manageer.dart';
import '../../shared/style.dart';
import '../../shared/utils.dart';
import '../forms/my_button.dart';
import '../forms/my_switchlist_tile.dart';
import '../forms/my_text_form_field.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({
    Key? key,
    required this.donor,
  }) : super(key: key);
  Donor? donor;
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  DateTime? newDate;
  String? selectedGender;
  ProfileLocalData? profileLocalData;
  Future<String> showDateTimePicker(context) async {
    final DateTime initDateTime = DateTime.now();
    newDate = await showDatePicker(
      context: context,
      initialDate: initDateTime,
      firstDate: DateTime(1900),
      lastDate: initDateTime,
    ).then((value) => newDate = value);
    if (newDate == null) return "";
    // final pickedDateTime = DateTime(
    //   newDate.year,
    //   newDate.month,
    //   newDate.day,
    // );
    // setDateTime(pickedDateTime);
    // setDateController(formatOnlyDate(pickedDateTime));
    return newDate.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.donor == null) {}
    fillProfileLocalData();
    // BlocProvider.of<ProfileCubit>(context).getDataToProfilePage();
  }

  fillProfileLocalData() {
    print("888888888888888888888888888888888888");
    print(widget.donor);
    profileLocalData = ProfileLocalData(
        date: widget.donor!.brithDate,
        isShown: widget.donor!.isShown,
        is_gps_on: widget.donor!.isGpsOn,
        is_shown_phone: widget.donor!.isShownPhone);
    // profileLocalData!.date = widget.donor!.brithDate;
    // profileLocalData!.isShown = widget.donor!.isShown;
    // profileLocalData!.is_shown_phone = widget.donor!.isShownPhone;
    // profileLocalData!.is_gps_on = widget.donor!.isGpsOn;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      const SizedBox(
        height: 10,
      ),
      editBasicData(
        donor: widget.donor!,
      ),
      valueListenableBuilder(widget.donor!),
    ]));
  }

  valueListenableBuilder(Donor donor) {
    return Column(
      children: [
        MySwitchListTile(
          title: "متاح",
          subTitle: "الظهور في قائمة المتبرعين",
          // onchangValue: (box.get("is_shown", defaultValue: "1") == "1")
          //     ? true
          //     : false,
          onchangValue: (donor.isShown.toString() == "1") ? true : false,
          onChange: (val) {
            // box.put("is_shown", val == true ? "1" : 0);
            profileLocalData!.isShown = val == true ? "1" : "0";
          },
        ),
        MySwitchListTile(
          title: "اضهار رقمي",
          subTitle: "سيظهر رقمك للجميع",
          onChange: (val) {
            // box.put("is_shown_phone", val == true ? "1" : 0);
            profileLocalData!.is_shown_phone = val == true ? "1" : "0";
          },
          // onchangValue:
          //     (box.get("is_shown_phone", defaultValue: "1") == "1")
          //         ? true
          //         : false,
          onchangValue: (donor.isShownPhone.toString() == "1") ? true : false,
        ),
        MySwitchListTile(
          title: "استخدام الموقع",
          subTitle: "تشغيل gbs",
          onChange: (val) {
            // box.put("is_gps_on", val == true ? "1" : 0);
            profileLocalData!.is_gps_on = val == true ? "1" : "0";
          },
          onchangValue: (donor.isGpsOn == "1") ? true : false,
          // onchangValue: (box.get("is_gps_on", defaultValue: "1") == "1")
          //     ? true
          //     : false,
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                    showDateTimePicker(context).then((value) {
                      if (value != "") {
                        // box.put("date", value);
                        profileLocalData!.date = value;
                      }
                    });
                  },
                ),
                // const SizedBox(height: 20),
              ],
            )),
        MyButton(
            title: "حفظ",
            minWidth: MediaQuery.of(context).size.width * 0.85,
            onPressed: (() {
              if (profileLocalData != null) {
                BlocProvider.of<ProfileCubit>(context)
                    .sendDataProfileSectionOne(profileLocalData!);
              } else {
                Utils.showSnackBar(
                  context: context,
                  msg: "تاكد من ضبط كل الخيارات بشكل صحيح",
                  color: ColorManager.error,
                );
              }
            }))
      ],
    );
  }
}

class editBasicData extends StatelessWidget {
  Donor donor;
  editBasicData({
    Key? key,
    required this.donor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        print("00000000000000000000000000000");
        print(";;;;;;;");
        print(donor);
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => EditMainDataPage(donor: donor)));
      },
    );
  }
}

class ProfileLocalData {
  late final String? isShown;
  String? date;
  String? is_gps_on;
  String? is_shown_phone;
  String? name;
  String? bloodType;
  String? district;
  String? state;
  String? neighborhood;

  ProfileLocalData(
      {this.name,
      this.bloodType,
      this.district,
      this.neighborhood,
      this.state,
      this.isShown,
      this.date,
      this.is_gps_on,
      this.is_shown_phone});
}
