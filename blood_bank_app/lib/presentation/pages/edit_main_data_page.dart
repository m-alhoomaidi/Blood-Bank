// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/domain/entities/blood_types.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';
import 'package:blood_bank_app/core/utils.dart';
import 'package:blood_bank_app/presentation/widgets/common/dialog_lottie.dart';
import 'package:blood_bank_app/presentation/widgets/setting/profile_body.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../resources/style.dart';
import '../widgets/edit_main_data/address.dart';
import '../widgets/edit_main_data/blood_type.dart';
import '../widgets/forms/my_button.dart';
import '../widgets/forms/my_dropdown_button_form_field.dart';
import '../widgets/forms/my_text_form_field.dart';
import 'setting_page.dart';

ProfileLocalData? profileLocalData;

class EditMainDataPage extends StatefulWidget {
  EditMainDataPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = "edit_main_data";

  @override
  State<EditMainDataPage> createState() => _EditMainDataPageState();
}

class _EditMainDataPageState extends State<EditMainDataPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formStateBloodType = GlobalKey<FormState>();
  String? bloodType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.profileEditMainDataPageTitle),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProfileLoadingBeforFetch) {
              return const MyLottie();
            }
            if (state is ProfileLoading) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            if (state is ProfileGetData) {
              profileLocalData = ProfileLocalData(
                  name: state.donors.name,
                  bloodType: state.donors.bloodType,
                  state: state.donors.state,
                  district: state.donors.district,
                  neighborhood: state.donors.neighborhood);
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p10, vertical: AppPadding.p10),
                      child: Text(AppStrings.editMainDataTextName),
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
                            return AppStrings.editMainDataTextNameValidator;
                          }
                          return null;
                        },
                        onSave: ((newValue) {
                          // box.put("name", newValue);
                          profileLocalData!.name = newValue;
                        }),
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p10, vertical: AppPadding.p10),
                      child: Text(AppStrings.profileBloodTypeTitle),
                    ),
                    MyDropdownButtonFormField(
                      hint: AppStrings.profileBloodTypeHint,
                      validator: (value) {
                        return (value == null)
                            ? AppStrings.profileValidatorCheckBloodType
                            : null;
                      },
                      value: (profileLocalData!.bloodType == null)
                          // (box.get("blood_type") == null)
                          ? bloodType
                          : profileLocalData!.bloodType,
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

                        setState(() {
                          profileLocalData!.bloodType = bloodType;
                        });
                      }),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p10, vertical: AppPadding.p10),
                      child: Text(AppStrings.profileAdressTitle),
                    ),
                    Column(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppSize.s10)),
                                    color: ColorManager.primary,
                                    border: Border.all(
                                      color: ColorManager.white,
                                      width: 1,
                                    ),
                                  ),
                                  dropDownPadding:
                                      const EdgeInsets.all(AppPadding.p12),
                                  // dropDownMargin: const EdgeInsets.symmetric(vertical: 4),
                                  spaceBetween: AppSize.s14,
                                  disabledDropdownDecoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppSize.s10)),
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
                                  currentState:
                                      (profileLocalData!.state == null)
                                          ? null
                                          : profileLocalData!.state!,
                                  currentCity:
                                      (profileLocalData!.district == null)
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
                              const SizedBox(height: AppSize.s14),
                              SizedBox(
                                // margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Form(
                                  key: _formStateBloodType,
                                  child: MyTextFormField(
                                    initialValue:
                                        ((profileLocalData!.neighborhood ==
                                                null)
                                            ? null
                                            : profileLocalData!.neighborhood),
                                    hint: "المنطقة",
                                    hintStyle: eHintStyle,
                                    blurrBorderColor: eFieldBlurrBorderColor,
                                    focusBorderColor: eFieldFocusBorderColor,
                                    fillColor: eFieldFillColor,
                                    suffixIcon: false,
                                    icon:
                                        const Icon(Icons.my_location_outlined),
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
                        const SizedBox(height: AppSize.s14),
                      ],
                    ),
                    const SizedBox(height: AppSize.s30),
                    MyButton(
                        title: AppStrings.profileButtonSave,
                        onPressed: (() {
                          if (_formState.currentState!.validate() |
                              _formStateBloodType.currentState!.validate()) {
                            _formState.currentState!.save();
                            _formStateBloodType.currentState!.save();
                            if (profileLocalData != null) {
                              profileLocalData!.bloodType = bloodType;
                              BlocProvider.of<ProfileCubit>(context)
                                  .sendBasicDataProfileSectionOne(
                                      profileLocalData!);
                            } else {
                              Utils.showSnackBar(
                                context: context,
                                msg: AppStrings.profileCheckChooseOption,
                                color: ColorManager.error,
                              );
                            }
                          }
                        }))
                  ],
                ),
              );
            } else {
              return const Center(
                child: MyLottie(),
              );
            }
          },
        ));
  }
}
//   MyDropdownButtonFormField myDropdownButtonFormField(
//       ProfileLocalData profileLocalData) {
//     return MyDropdownButtonFormField(
//       hint: "فصيلة دمك",
//       validator: (value) {
//         return (value == null) ? 'يرجى اختيار فصيلة الدم' : null;
//       },
//       value: (profileLocalData.bloodType == null)
//           // (box.get("blood_type") == null)
//           ? bloodType
//           : profileLocalData.bloodType,
//       // : box.get("blood_type"),
//       hintColor: eTextColor,
//       items: BloodTypes.bloodTypes,
//       blurrBorderColor: eFieldBlurrBorderColor,
//       focusBorderColor: eFieldFocusBorderColor,
//       fillColor: eFieldFillColor,
//       icon: const Icon(Icons.bloodtype_outlined),
//       onChange: (value) => setState(() {
//         bloodType = value;
//         // box.put("blood_type", bloodType);
//         setState(() {
//           profileLocalData.bloodType = value;
//         });

//         print(";;;;;;;;;sssssssss");
//       }),
//     );
//   }
// }

// // ignore: camel_case_types
// class addressData extends StatelessWidget {
//   const addressData({
//     Key? key,
//     required this.profileLocalData,
//     required GlobalKey<FormState> formStateBloodType,
//   })  : _formStateBloodType = formStateBloodType,
//         super(key: key);

//   final ProfileLocalData? profileLocalData;
//   final GlobalKey<FormState> _formStateBloodType;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           // height: stepContentHeight,
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 // margin: const EdgeInsets.symmetric(horizontal: 20),
//                 child: CSCPicker(
//                   layout: Layout.vertical,
//                   showStates: true,
//                   showCities: true,
//                   flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     color: Colors.red[100],
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 1,
//                     ),
//                   ),
//                   dropDownPadding: const EdgeInsets.all(12),
//                   // dropDownMargin: const EdgeInsets.symmetric(vertical: 4),
//                   spaceBetween: 15.0,
//                   disabledDropdownDecoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     color: Colors.grey.shade300,
//                     border: Border.all(
//                       color: Colors.grey.shade300,
//                       width: 1,
//                     ),
//                   ),
//                   countrySearchPlaceholder: "الدولة",
//                   stateSearchPlaceholder: "المحافطة",
//                   citySearchPlaceholder: "المديرية",
//                   countryDropdownLabel: "الدولة",
//                   stateDropdownLabel: "المحافطة",
//                   cityDropdownLabel: "المديرية",
//                   defaultCountry: DefaultCountry.Yemen,

//                   selectedItemStyle: const TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 16,
//                   ),
//                   dropdownHeadingStyle: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                   dropdownItemStyle: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                   ),
//                   dropdownDialogRadius: 10.0,
//                   searchBarRadius: 10.0,
//                   currentState: (profileLocalData!.state == null)
//                       ? null
//                       : profileLocalData!.state!,
//                   currentCity: (profileLocalData!.district == null)
//                       ? null
//                       : profileLocalData!.district,
//                   onStateChanged: (value) {
//                     // stateName = value;
//                     print(profileLocalData!.state);
//                     // box.put("state_name", value);
//                     profileLocalData!.state = value;
//                   },
//                   onCityChanged: (value) {
//                     // district = value;
//                     // box.put("district", value);
//                     profileLocalData!.district = value;
//                   },
//                 ),
//               ),
//               const SizedBox(height: 15.0),
//               SizedBox(
//                 // margin: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Form(
//                   key: _formStateBloodType,
//                   child: MyTextFormField(
//                     initialValue: ((profileLocalData!.neighborhood == null)
//                         ? null
//                         : profileLocalData!.neighborhood),
//                     hint: "المنطقة",
//                     hintStyle: eHintStyle,
//                     blurrBorderColor: eFieldBlurrBorderColor,
//                     focusBorderColor: eFieldFocusBorderColor,
//                     fillColor: eFieldFillColor,
//                     suffixIcon: false,
//                     icon: const Icon(Icons.my_location_outlined),
//                     onSave: (value) {
//                       // neighborhood = value;
//                       // box.put("neighborhood", value);
//                       profileLocalData!.neighborhood = value;
//                     },
//                     validator: (value) {
//                       if (value!.length < 2) {
//                         return "يرجى كتابة قريتك أو حارتك";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 15.0),
//       ],
//     );
//   }
// }
