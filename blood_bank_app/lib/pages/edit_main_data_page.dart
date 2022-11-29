import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/blood_types.dart';
import '../shared/style.dart';
import '../widgets/forms/my_dropdown_button_form_field.dart';

class EditMainDataPage extends StatefulWidget {
  const EditMainDataPage({super.key});
  static const String routeName = "edit_main_data";

  @override
  State<EditMainDataPage> createState() => _EditMainDataPageState();
}

class _EditMainDataPageState extends State<EditMainDataPage> {
  String? bloodType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("الاسم"),
            ),
            MyTextFormField(
              validator: (value) {
                if (value!.length < 2) {
                  return "لا يمكن أن يكون الاسم أقل من حرفين";
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("العنوان"),
            ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                      onStateChanged: (value) {
                        // stateName = value;
                      },
                      onCityChanged: (value) {
                        // district = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "المنطقة",
                      hintStyle: eHintStyle,
                      blurrBorderColor: Colors.white,
                      focusBorderColor: eTextFieldFocusBorder,
                      fillColor: eTextFieldFill,
                      icon: const Icon(Icons.my_location_outlined),
                      onSave: (value) {
                        // neighborhood = value;
                      },
                      validator: (value) {
                        if (value!.length < 2) {
                          return "يرجى كتابة قريتك أو حارتك";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("الفصيلة"),
            ),
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
          ],
        ),
      ),
    );
  }
}
