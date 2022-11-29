import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../shared/style.dart';
import '../forms/my_text_form_field.dart';

class AddressMainData extends StatefulWidget {
  const AddressMainData({super.key});

  @override
  State<AddressMainData> createState() => _AddressMainDataState();
}

class _AddressMainDataState extends State<AddressMainData> {
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
        const SizedBox(height: 15.0),
      ],
    );
  }
}
