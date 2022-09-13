import '../style.dart';
import '../widgets/forms/my_outlined_icon_button.dart';
import '../widgets/forms/my_dropdown_button_form_field.dart';
import '../widgets/forms/my_text_form_field.dart';
import '../widgets/forms/my_checkbox_form_field.dart';
import '../pages/sing_up_center_page.dart';
import '../models/my_stepper.dart' as my_stepper;
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = "sign-up";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _saving = false;
  final GlobalKey<FormState> _firstFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _thirdFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _fourthFormState = GlobalKey<FormState>();

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

  Future submit() async {
    FormState? formData = _firstFormState.currentState;
    if (formData!.validate()) {
      formData.save();
      setState(() => _saving = true);
      // await function();
    } else {
      print("Not Valid");
    }
  }

  bool isFirstStep() => _activeStepIndex == 0;

  bool isLastStep() => _activeStepIndex == stepList().length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب متبرع'),
        centerTitle: true,
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
            }
          },
          onStepCancel: () {
            if (isFirstStep()) {
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
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                      ),
                      if (!isFirstStep())
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
                      const SizedBox(width: 20),
                      Positioned(
                        left: 20,
                        child: SizedBox(
                          width: 140,
                          child: (isLastStep())
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
                                  onPressed: () {
                                    _fourthFormState.currentState!.validate();
                                  },
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
                  isFirstStep()
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: const Text(
                              "إنشاء حساب كمركز طبي",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUpCenter.routeName);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<my_stepper.Step> stepList() => <my_stepper.Step>[
        firstStep(),
        secondSetp(),
        thirdStep(),
        fourthStep(),
      ];

  my_stepper.Step firstStep() {
    return my_stepper.Step(
      state: _activeStepIndex <= 0
          ? my_stepper.StepState.editing
          : my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text("حسابك", style: TextStyle(fontSize: 12)),
      content: SizedBox(
        height: stepContentHeight,
        child: Form(
          key: _firstFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "بخطواتـك هذه قد تـنـقـذ حيـاة إنــسان",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "بريدك الإلكتروني",
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
                  onSave: (value) {},
                  validator: (value) =>
                      value != null && EmailValidator.validate(value)
                          ? null
                          : "اكتب بريد إيميل صحيح",
                  icon: Icons.email,
                  keyBoardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "أنشئ كلمة مرور",
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
                  isPassword: true,
                  onSave: (value) {},
                  validator: (value) {
                    if (value!.length < 6) {
                      return "يجب أن يكون طول كلمة المرور ستة أو أكثر";
                    }
                    return null;
                  },
                  icon: Icons.password,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  my_stepper.Step secondSetp() {
    return my_stepper.Step(
      state: _activeStepIndex <= 1
          ? my_stepper.StepState.editing
          : my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 1,
      title: const Text("بياناتك", style: TextStyle(fontSize: 12)),
      content: SizedBox(
        height: stepContentHeight,
        child: Form(
          key: _secondFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "اسمك",
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
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
                  hint: "رقم هاتفك",
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
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
                  hint: "فصيلة دمك",
                  value: selectedBloodType,
                  items: bloodTypes,
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
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

  my_stepper.Step thirdStep() {
    return my_stepper.Step(
      state: _activeStepIndex <= 2
          ? my_stepper.StepState.editing
          : my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 2,
      title: const Text("عنوانك", style: TextStyle(fontSize: 12)),
      content: SizedBox(
        height: stepContentHeight,
        child: Form(
          key: _thirdFormState,
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.red[100],
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  dropDownPadding: const EdgeInsets.all(12),
                  // dropDownMargin: const EdgeInsets.symmetric(vertical: 4),
                  spaceBetween: 20.0,
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
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "المنطقة",
                  blurrBorderColor: Colors.white,
                  focusBorderColor: eTextFiledFocusBorder,
                  fillColor: eTextFiledFill,
                  icon: Icons.my_location_outlined,
                  onSave: (value) {},
                  validator: (value) {
                    if (value!.length != 9) {
                      return "يجب أن يكون عدد الأرقام 9";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  my_stepper.Step fourthStep() {
    return my_stepper.Step(
      state: my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 3,
      title: const Text("تأكيد", style: TextStyle(fontSize: 12)),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: stepContentHeight,
        child: Column(
          children: [
            Wrap(
              children: [
                buildDonorDetail(
                  key: "اسم المتبرع",
                  value: "عزالعرب مفيد الحميدي",
                ),
                buildDonorDetail(
                  key: "رقم الهاتف",
                  value: "714296685",
                ),
                buildDonorDetail(
                  key: "فصيلة الدم",
                  value: "O+",
                ),
                buildDonorDetail(
                  key: "العنوان",
                  value: "إب - الظهار - قحزة",
                ),
                buildDonorDetail(
                  key: "البريد الإلكتروني",
                  value: "ezz2019alarab@gmail.com",
                ),
              ],
            ),
            Form(
              key: _fourthFormState,
              child: MyCheckboxFormField(
                title: Row(
                  children: [
                    const Text("أوافق على "),
                    GestureDetector(
                      child: const Text(
                        "سياسات الخصوصية",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                onSaved: (value) {},
                validator: (value) => !value! ? "يجب أن تؤكد موافقتك" : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildDonorDetail({
    required String key,
    required String value,
  }) {
    return SizedBox(
      height: 28,
      child: Wrap(
        children: [
          Text(
            "$key:  ",
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
    );
  }
}
