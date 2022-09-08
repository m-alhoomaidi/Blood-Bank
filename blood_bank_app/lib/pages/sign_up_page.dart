import 'package:blood_bank_app/widgets/my_outlined_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/my_dropdown_button_form_field.dart';
import '../widgets/my_text_form_field.dart';
import '../models/my_stepper.dart' as my_stepper;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = "form";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _saving = false;
  final GlobalKey<FormState> _formFirstState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSecondState = GlobalKey<FormState>();

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

  String? selectedGovernorate;
  String? selectedDistrict;
  String? selectedBloodType;

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

  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<my_stepper.Step> stepList() => [
        my_stepper.Step(
          state: _activeStepIndex <= 0
              ? my_stepper.StepState.editing
              : my_stepper.StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(''),
          content: SizedBox(
            height: 200,
            child: Form(
              key: _formFirstState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "Enter Your Name",
                      onSave: (value) {},
                      validator: (value) {
                        if (value!.length < 2) {
                          return "Name Can't be less than 2 letters";
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
                      hint: "Enter Your Phone Number",
                      onSave: (value) {},
                      validator: (value) {
                        if (value!.length != 9) {
                          return "Phone number must be 9 numbers long";
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
                      hint: "Select Your Blood Type",
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
            height: 200,
            child: Form(
              key: _formSecondState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyDropdownButtonFormField(
                      hint: "Select Your Governorate",
                      value: selectedGovernorate,
                      items: governorates,
                      icon: const Icon(Icons.location_city_outlined),
                      onChange: (value) =>
                          setState(() => selectedGovernorate = value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyDropdownButtonFormField(
                      hint: "Select Your District",
                      value: selectedDistrict,
                      items: districs,
                      icon: const Icon(Icons.location_on_outlined),
                      onChange: (value) =>
                          setState(() => selectedDistrict = value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "Enter Your Blood Type",
                      onSave: (value) {},
                      icon: Icons.my_location_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        my_stepper.Step(
          state: my_stepper.StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text(''),
          content: const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Review & Confirm",
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
          'Sign up From',
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
                      left: 20,
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
                            'Back',
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
                    right: 20,
                    child: SizedBox(
                      width: 140,
                      child: (isLastStep)
                          ? MyOutlinedIconButton(
                              icon: const Text(
                                'Submit',
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
                                'Next',
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
