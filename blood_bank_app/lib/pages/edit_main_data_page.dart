// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/widgets/setting/profile_body.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blood_bank_app/domain/entities/donor.dart';

import '../models/blood_types.dart';
import '../shared/style.dart';
import '../widgets/edit_main_data/address.dart';
import '../widgets/edit_main_data/blood_type.dart';
import '../widgets/forms/my_button.dart';
import '../widgets/forms/my_dropdown_button_form_field.dart';
import '../widgets/forms/my_text_form_field.dart';
import 'setting_page.dart';

class EditMainDataPage extends StatefulWidget {
  Donor? donor;
  EditMainDataPage({
    Key? key,
    required this.donor,
  }) : super(key: key);
  static const String routeName = "edit_main_data";

  @override
  State<EditMainDataPage> createState() => _EditMainDataPageState();
}

class _EditMainDataPageState extends State<EditMainDataPage> {
  ProfileLocalData? profileLocalData;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formStateBloodType = GlobalKey<FormState>();
  String? bloodType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileLocalData = ProfileLocalData(
        name: widget.donor!.name,
        bloodType: widget.donor!.bloodType,
        state: widget.donor!.state,
        district: widget.donor!.district,
        neighborhood: widget.donor!.neighborhood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("تعديل البيانات الاساسية"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text("الاسم"),
              ),
              Form(
                key: _formState,
                child: MyTextFormField(
                  initialValue: (profileLocalData!.name == null)
                      ? null
                      : profileLocalData!.name,
                  // (box.get("name") == null) ? null : box.get("name"),
                  validator: (value) {
                    if (value!.length < 2) {
                      return "لا يمكن أن يكون الاسم أقل من حرفين";
                    }
                    return null;
                  },
                  onSave: ((newValue) {
                    // box.put("name", newValue);
                    profileLocalData!.name = newValue;
                  }),
                ),
              ),
              const SizedBox(height: 15.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text("الفصيلة"),
              ),
              myDropdownButtonFormField(profileLocalData!),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text("العنوان"),
              ),
              addressData(
                  profileLocalData: profileLocalData,
                  formStateBloodType: _formStateBloodType),
              const SizedBox(height: 30.0),
              MyButton(
                  title: "حفظ",
                  onPressed: (() {
                    if (_formState.currentState!.validate() |
                        _formStateBloodType.currentState!.validate()) {
                      _formState.currentState!.save();
                      _formStateBloodType.currentState!.save();
                    }
                  }))
            ],
          ),
        ));
  }

  MyDropdownButtonFormField myDropdownButtonFormField(
      ProfileLocalData profileLocalData) {
    return MyDropdownButtonFormField(
      hint: "فصيلة دمك",
      validator: (value) {
        return (value == null) ? 'يرجى اختيار فصيلة الدم' : null;
      },
      value: (profileLocalData.bloodType == null)
          // (box.get("blood_type") == null)
          ? bloodType
          : profileLocalData.bloodType,
      // : box.get("blood_type"),
      hintColor: eTextColor,
      items: BloodTypes.bloodTypes,
      blurrBorderColor: eFieldBlurrBorderColor,
      focusBorderColor: eFieldFocusBorderColor,
      fillColor: eFieldFillColor,
      icon: const Icon(Icons.bloodtype_outlined),
      onChange: (value) => setState(() {
        bloodType = value;
        // box.put("blood_type", bloodType);
        profileLocalData.bloodType = value;
      }),
    );
  }
}

// ignore: camel_case_types
class addressData extends StatelessWidget {
  const addressData({
    Key? key,
    required this.profileLocalData,
    required GlobalKey<FormState> formStateBloodType,
  })  : _formStateBloodType = formStateBloodType,
        super(key: key);

  final ProfileLocalData? profileLocalData;
  final GlobalKey<FormState> _formStateBloodType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // height: stepContentHeight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CSCPicker(
                  layout: Layout.vertical,
                  showStates: true,
                  showCities: true,
                  flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.red[100],
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  dropDownPadding: const EdgeInsets.all(12),
                  // dropDownMargin: const EdgeInsets.symmetric(vertical: 4),
                  spaceBetween: 15.0,
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  countrySearchPlaceholder: "الدولة",
                  stateSearchPlaceholder: "المحافطة",
                  citySearchPlaceholder: "المديرية",
                  countryDropdownLabel: "الدولة",
                  stateDropdownLabel: "المحافطة",
                  cityDropdownLabel: "المديرية",
                  defaultCountry: DefaultCountry.Yemen,

                  selectedItemStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  dropdownHeadingStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  dropdownItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  dropdownDialogRadius: 10.0,
                  searchBarRadius: 10.0,
                  currentState: (profileLocalData!.state == null)
                      ? null
                      : profileLocalData!.state!,
                  currentCity: (profileLocalData!.district == null)
                      ? null
                      : profileLocalData!.district,
                  onStateChanged: (value) {
                    // stateName = value;
                    print(profileLocalData!.state);
                    // box.put("state_name", value);
                    profileLocalData!.state = value;
                  },
                  onCityChanged: (value) {
                    // district = value;
                    // box.put("district", value);
                    profileLocalData!.district = value;
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                // margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formStateBloodType,
                  child: MyTextFormField(
                    initialValue: ((profileLocalData!.neighborhood == null)
                        ? null
                        : profileLocalData!.neighborhood),
                    hint: "المنطقة",
                    hintStyle: eHintStyle,
                    blurrBorderColor: eFieldBlurrBorderColor,
                    focusBorderColor: eFieldFocusBorderColor,
                    fillColor: eFieldFillColor,
                    suffixIcon: false,
                    icon: const Icon(Icons.my_location_outlined),
                    onSave: (value) {
                      // neighborhood = value;
                      // box.put("neighborhood", value);
                      profileLocalData!.neighborhood = value;
                    },
                    validator: (value) {
                      if (value!.length < 2) {
                        return "يرجى كتابة قريتك أو حارتك";
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
