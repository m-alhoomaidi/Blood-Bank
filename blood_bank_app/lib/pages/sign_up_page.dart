import 'package:blood_bank_app/style.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/my_outlined_icon_button.dart';
import '../widgets/my_dropdown_button_form_field.dart';
import '../widgets/my_text_form_field.dart';
import '../models/my_stepper.dart' as my_stepper;
// import '../models/csc_picker_ar.dart' as csc_ar;

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
  bool didConfirm = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب متبرع'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: my_stepper.Stepper(
          svgPictureAsset: "assets/images/blood_drop.svg",
          iconColor: Theme.of(context).primaryColor,
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
                                Icons.check_rounded,
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

  List<my_stepper.Step> stepList() => [
        firstStep(),
        secondStep(),
        thirdStep(),
      ];

  my_stepper.Step firstStep() {
    return my_stepper.Step(
      state: _activeStepIndex <= 0
          ? my_stepper.StepState.editing
          : my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text("بياناتك", style: TextStyle(fontSize: 12)),
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
                  blurrBorderColor: Colors.white,
                  fillColor: Colors.red[100],
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
                  blurrBorderColor: Colors.white,
                  fillColor: Colors.red[100],
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
                  fillColor: Colors.red[100],
                  blurrBorderColor: Colors.white,
                  icon: const Icon(Icons.bloodtype_outlined),
                  onChange: (value) =>
                      setState(() => selectedBloodType = value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  my_stepper.Step secondStep() {
    return my_stepper.Step(
      state: _activeStepIndex <= 1
          ? my_stepper.StepState.editing
          : my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 1,
      title: const Text("عنوانك", style: TextStyle(fontSize: 12)),
      content: SizedBox(
        height: stepContentHeight,
        child: Form(
          key: _formSecondState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CSCPicker(
                  layout: Layout.vertical,
                  showStates: true,
                  showCities: true,
                  flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.red[100],
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  dropDownPadding: const EdgeInsets.all(12),
                  dropDownMargin: const EdgeInsets.symmetric(vertical: 4),
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                  // currentCity:
                  //     Provider.of<ProviderSignInOut>(context).cityValue,
                  // currentState:
                  //     Provider.of<ProviderSignInOut>(context).stateValue,
                  // currentCountry:
                  //     Provider.of<ProviderSignInOut>(context).countryValue,
                  ///Disable country dropdown (Note: use it with default country)
                  // disableCountry: true,

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
                  onCountryChanged: (value) {},
                  onStateChanged: (value) {},
                  onCityChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  my_stepper.Step thirdStep() {
    return my_stepper.Step(
      state: my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 2,
      title: const Text("تأكيد", style: TextStyle(fontSize: 12)),
      content: SizedBox(
        height: stepContentHeight,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("اسمك", style: TextStyle(height: 1.5)),
                      Text("رقمك", style: TextStyle(height: 1.5)),
                      Text("فصيلة دمك", style: TextStyle(height: 1.5)),
                      Text("المحافظة", style: TextStyle(height: 1.5)),
                      Text("المديرية", style: TextStyle(height: 1.5)),
                      Text("المنطقة", style: TextStyle(height: 1.5)),
                    ],
                  ),
                  const VerticalDivider(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildDonorDetail("اسم المتبرع"),
                      buildDonorDetail("714296685"),
                      buildDonorDetail("O+"),
                      buildDonorDetail("إب"),
                      buildDonorDetail("الظهار"),
                      buildDonorDetail("السبل"),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Checkbox(
                    value: didConfirm,
                    onChanged: (value) => setState(() => didConfirm = value!)),
                TextButton(
                  onPressed: () {},
                  child: const Text("أوافق على سياسات الخصوصية"),
                  style: TextButton.styleFrom(primary: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text buildDonorDetail(String detail) {
    return Text(
      detail,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.5,
      ),
    );
  }
}
