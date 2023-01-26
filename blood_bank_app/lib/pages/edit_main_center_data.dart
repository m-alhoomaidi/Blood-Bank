// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/pages/profile_center.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';
import 'package:blood_bank_app/shared/utils.dart';
import 'package:blood_bank_app/widgets/dialog_lottie.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../shared/style.dart';
import '../widgets/forms/my_button.dart';
import '../widgets/forms/my_text_form_field.dart';

ProfileCenterData? profileCenterData;

class EditMainCenterDataPage extends StatefulWidget {
  EditMainCenterDataPage({
    Key? key,
  }) : super(key: key);
  static const String routeName = "edit_main_center_data";

  @override
  State<EditMainCenterDataPage> createState() => _EditMainCenterDataPageState();
}

class _EditMainCenterDataPageState extends State<EditMainCenterDataPage> {
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

            if (state is ProfileGetCenterData) {
              profileCenterData = ProfileCenterData(
                  name: state.bloodCenter.name,
                  phone: state.bloodCenter.phone,
                  state: state.bloodCenter.state,
                  district: state.bloodCenter.district,
                  neighborhood: state.bloodCenter.neighborhood);
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
                      child: Column(
                        children: [
                          MyTextFormField(
                            initialValue: (profileCenterData!.name == null)
                                ? null
                                : profileCenterData!.name,
                            // (box.get("name") == null) ? null : box.get("name"),
                            validator: (value) {
                              if (value!.length < 2) {
                                return AppStrings.editMainDataTextNameValidator;
                              }
                              return null;
                            },
                            onSave: ((newValue) {
                              // box.put("name", newValue);
                              profileCenterData!.name = newValue;
                            }),
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                "الرقم",
                              ),
                            ),
                          ),
                          MyTextFormField(
                            initialValue: profileCenterData!.phone,
                            // (box.get("name") == null) ? null : box.get("name"),
                            validator: _phoneNumberValidator,
                            onSave: ((newValue) {
                              // box.put("name", newValue);
                              profileCenterData!.phone = newValue;
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
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
                                    color: Colors.red[100],
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
                                      (profileCenterData!.state == null)
                                          ? null
                                          : profileCenterData!.state!,
                                  currentCity:
                                      (profileCenterData!.district == null)
                                          ? null
                                          : profileCenterData!.district,
                                  onStateChanged: (value) {
                                    // stateName = value;
                                    print(profileCenterData!.state);
                                    // box.put("state_name", value);
                                    profileCenterData!.state = value;
                                  },
                                  onCityChanged: (value) {
                                    // district = value;
                                    // box.put("district", value);
                                    profileCenterData!.district = value;
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
                                        ((profileCenterData!.neighborhood ==
                                                null)
                                            ? null
                                            : profileCenterData!.neighborhood),
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
                                      profileCenterData!.neighborhood = value;
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
                          if (_formState.currentState!.validate()) {
                            _formState.currentState!.save();
                            if (profileCenterData != null) {
                              BlocProvider.of<ProfileCubit>(context)
                                  .sendBasicCenterDataProfile(
                                      profileCenterData!);
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
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

String? _phoneNumberValidator(String? value) {
  String pattern = r"^\+?7[0|1|3|7|8][0-9]{7}$";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return AppStrings.signUpPhoneValidator;
  } else {
    return null;
  }
}
