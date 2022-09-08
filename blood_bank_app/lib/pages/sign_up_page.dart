import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/my_outlined_icon_button.dart';
import '../widgets/my_dropdown_button_form_field.dart';
import '../widgets/my_text_form_field.dart';
import '../models/my_stepper.dart' as my_stepper;
import '../models/csc_picker_ar.dart' as csc_ar;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = "sign-up";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _saving = false;
  final GlobalKey<FormState> _formFirstState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSecondState = GlobalKey<FormState>();

  String? selectedGovernorate;
  String? selectedDistrict;
  String? selectedBloodType;

  final double stepContentHeight = 200.0;
  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  final List<String> bloodTypes = const <String>[
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

  final List<String> governorates = const [
    "Ibb",
    "Sana'a",
    "Taiz",
    "Aden",
    "Thamar",
    "Hodaidah"
  ];

  final List<String> districs = const [
    "Al-Dhehar",
    "Al-Mashanna",
    "Al-Odain",
    "Hobaish"
  ];

  Future submit() async {
    FormState? formData = _formFirstState.currentState;
    if (formData!.validate()) {
      formData.save();
      setState(() => _saving = true);
      // await function();
    } else {
      print("Not Valid");
    }
  }

  List<my_stepper.Step> stepList() => [
        my_stepper.Step(
          state: _activeStepIndex <= 0
              ? my_stepper.StepState.editing
              : my_stepper.StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(''),
          content: SizedBox(
            height: stepContentHeight,
            child: Form(
              key: _formFirstState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "اكتب اسمك",
                      onSave: (value) {},
                      validator: (value) {
                        if (value!.length < 2) {
                          return "لا يمكن أن يكون الاسم أقل من حرفين";
                        }
                        return null;
                      },
                      icon: Icons.person,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "اكتب رقم هاتفك",
                      onSave: (value) {},
                      validator: (value) {
                        if (value!.length != 9) {
                          return "يجب أن يكون عدد الأرقام 9";
                        }
                        return null;
                      },
                      icon: Icons.phone_android,
                      keyBoardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyDropdownButtonFormField(
                      hint: "اختر فصيلة دمك",
                      value: selectedBloodType,
                      items: bloodTypes,
                      icon: const Icon(Icons.bloodtype_outlined),
                      onChange: (value) =>
                          setState(() => selectedBloodType = value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        my_stepper.Step(
          state: _activeStepIndex <= 1
              ? my_stepper.StepState.editing
              : my_stepper.StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text(''),
          content: SizedBox(
            height: stepContentHeight,
            child: Form(
              key: _formSecondState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Adding CSC Picker Widget in app
                  csc_ar.CSCPicker(
                    layout: csc_ar.Layout.vertical,
                    // currentCountry: countryValue,
                    // currentCity: cityValue,
                    // currentState: stateValue,

                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: true,

                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: true,

                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: csc_ar.CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    //placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "الدولة",
                    stateDropdownLabel: "المحافطة",
                    cityDropdownLabel: "المديرية",

                    ///Default Country
                    defaultCountry: csc_ar.DefaultCountry.Yemen,
                    // currentCity:
                    //     Provider.of<ProviderSignInOut>(context).cityValue,
                    // currentState:
                    //     Provider.of<ProviderSignInOut>(context).stateValue,
                    // currentCountry:
                    //     Provider.of<ProviderSignInOut>(context).countryValue,

                    ///Disable country dropdown (Note: use it with default country)
                    // disableCountry: true,

                    ///selected item style [OPTIONAL PARAMETER]
                    selectedItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///Dialog box radius [OPTIONAL PARAMETER]
                    dropdownDialogRadius: 10.0,

                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: 10.0,

                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {},

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {},

                    // ///triggers once city selected in dropdown
                    onCityChanged: (value) {},
                  ),

                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: MyDropdownButtonFormField(
                  //     hint: "اختر محافظتك",
                  //     value: selectedGovernorate,
                  //     items: governorates,
                  //     icon: const Icon(Icons.location_city_outlined),
                  //     onChange: (value) =>
                  //         setState(() => selectedGovernorate = value),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: MyDropdownButtonFormField(
                  //     hint: "اختر مديريتك",
                  //     value: selectedDistrict,
                  //     items: districs,
                  //     icon: const Icon(Icons.location_on_outlined),
                  //     onChange: (value) =>
                  //         setState(() => selectedDistrict = value),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: MyTextFormField(
                  //     hint: "حارتك أو قريتك",
                  //     onSave: (value) {},
                  //     icon: Icons.my_location_outlined,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        my_stepper.Step(
          state: my_stepper.StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text(''),
          content: SizedBox(
            height: stepContentHeight,
            child: const Center(
              child: Text(
                "مراجعة بيانات المستخدم",
              ),
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إنشاء حساب متبرع',
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: my_stepper.Stepper(
          svgPictureAsset: "assets/images/blood_drop.svg",
          iconColor: Colors.red,
          elevation: 0,
          type: my_stepper.StepperType.horizontal,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              print('Submited');
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder:
              (BuildContext context, my_stepper.ControlsDetails controls) {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                  ),
                  if (_activeStepIndex > 0)
                    Positioned(
                      right: 20,
                      child: SizedBox(
                        width: 140,
                        child: MyOutlinedIconButton(
                          onPressed: controls.onStepCancel,
                          borderColor: Colors.orange,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.orange,
                          ),
                          label: const Text(
                            'السابق',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 20,
                  ),
                  Positioned(
                    left: 20,
                    child: SizedBox(
                      width: 140,
                      child: (isLastStep)
                          ? MyOutlinedIconButton(
                              icon: const Text(
                                'إنشاء',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                              label: const Icon(
                                Icons.arrow_forward,
                                color: Colors.green,
                              ),
                              onPressed: controls.onStepContinue,
                              borderColor: Colors.green,
                            )
                          : MyOutlinedIconButton(
                              icon: const Text(
                                'التالي',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              label: const Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                              onPressed: controls.onStepContinue,
                              borderColor: Colors.blue,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
