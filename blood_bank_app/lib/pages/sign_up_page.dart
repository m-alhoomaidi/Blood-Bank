import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/constatns.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/signup_cubit/signup_cubit.dart';
import '../models/blood_types.dart';
import '../domain/entities/donor.dart';
import '../models/my_stepper.dart' as my_stepper;
import '../pages/home_page.dart';
import '../pages/sing_up_center_page.dart';
import '../shared/encryption.dart';
import '../shared/style.dart';
import '../shared/utils.dart';
import '../widgets/forms/my_checkbox_form_field.dart';
import '../widgets/forms/my_dropdown_button_form_field.dart';
import '../widgets/forms/my_outlined_icon_button.dart';
import '../widgets/forms/my_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = "/sign-up";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _firstFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _secondFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _thirdFormState = GlobalKey<FormState>();
  final GlobalKey<FormState> _fourthFormState = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController(),
      phoneController = TextEditingController(),
      stateNameController = TextEditingController(),
      districtController = TextEditingController(),
      neighborhoodController = TextEditingController();

  String? selectedGovernorate, selectedDistrict, bloodType;

  int _activeStepIndex = 0;
  bool isPasswordVisible = true;
  bool isFirstStep() => _activeStepIndex == 0;
  bool isLastStep() => _activeStepIndex == stepList().length - 1;

  String? passwordValidator(value) {
    if (value!.length < minCharsOfPassword) {
      return AppStrings.signInPasswordFieldValidatorError;
    }
    return null;
  }

  _toggleIsPasswordVisible() {
    setState(() => isPasswordVisible = !isPasswordVisible);
  }

  Future<void> submit() async {
    FormState? formData = _fourthFormState.currentState;
    if (formData!.validate()) {
      BlocProvider.of<SignUpCubit>(context).signUp(
        donor: Donor(
          email: emailController.text,
          password: Encryption.encode(passwordController.text),
          name: nameController.text,
          phone: phoneController.text,
          bloodType: bloodType!,
          state: stateNameController.text,
          district: districtController.text,
          neighborhood: neighborhoodController.text,
        ),
      );
    }
  }

  FormState? currentFormState() {
    if (_activeStepIndex == 0) {
      return _firstFormState.currentState;
    } else if (_activeStepIndex == 1) {
      return _secondFormState.currentState;
    } else if (_activeStepIndex == 2) {
      return _thirdFormState.currentState;
    }
    return null;
  }

  void validateForm({int? stepIndex}) {
    FormState? formData = currentFormState();
    if (_activeStepIndex == 2 && districtController == null) {
      Fluttertoast.showToast(msg: 'يجب اختيار المحافظة والمديرية');
    } else {
      if (formData!.validate()) {
        formData.save();
        if (stepIndex == null) {
          setState(() => _activeStepIndex++);
        } else {
          setState(() => _activeStepIndex = stepIndex);
        }
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    stateNameController.dispose();
    districtController.dispose();
    neighborhoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء حساب متبرع'),
        centerTitle: true,
      ),
      body: BlocConsumer<SignUpCubit, SignupState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Utils.showSnackBar(
              context: context,
              msg: 'تم إنشاء حساب بنجاح',
              color: Colors.green,
            );
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          } else if (state is SignUpFailure) {
            Utils.showSnackBar(context: context, msg: state.error);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: (state is SignupLoading),
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
                setState(() => _activeStepIndex -= 1);
              },
              onStepTapped: (int index) {
                validateForm(stepIndex: index);
              },
              controlsBuilder:
                  (BuildContext context, my_stepper.ControlsDetails controls) {
                return buildNavigationButtons(context, controls);
              },
            ),
          );
        },
      ),
    );
  }

  Container buildNavigationButtons(
      BuildContext context, my_stepper.ControlsDetails controls) {
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
                          onPressed: () async {
                            submit();
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
                          onPressed: validateForm,
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
      title: Text("حسابك", style: Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: AppSize.s300,
        child: Form(
          key: _firstFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "بخطواتـك هذه قد تـنـقـذ حيـاة إنــسان",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 40.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "بريدك الإلكتروني",
                  controller: emailController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: (value) =>
                      value != null && EmailValidator.validate(value)
                          ? null
                          : "اكتب بريد إيميل صحيح",
                  icon: const Icon(Icons.email),
                  keyBoardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "أنشئ كلمة مرور",
                  controller: passwordController,
                  isPassword: isPasswordVisible,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: passwordValidator,
                  icon: IconButton(
                    icon: _buildPasswordIcon(),
                    onPressed: _toggleIsPasswordVisible,
                  ),
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
      title: Text("بياناتك", style: Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: AppSize.s300,
        child: Form(
          key: _secondFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "اسمك",
                  controller: nameController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: (value) {
                    if (value!.length < 2) {
                      return "لا يمكن أن يكون الاسم أقل من حرفين";
                    }
                    return null;
                  },
                  icon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "رقم هاتفك",
                  controller: phoneController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: (value) {
                    if (value!.length != 9) {
                      return "يجب أن يكون عدد الأرقام 9";
                    }
                    return null;
                  },
                  icon: const Icon(Icons.phone_android),
                  keyBoardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyDropdownButtonFormField(
                  hint: "فصيلة دمك",
                  validator: (value) {
                    return (value == null) ? 'يرجى اختيار فصيلة الدم' : null;
                  },
                  value: bloodType,
                  hintColor: eTextColor,
                  items: BloodTypes.bloodTypes,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  icon: const Icon(Icons.bloodtype_outlined),
                  onChange: (value) => setState(() => bloodType = value!),
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
      title: Text("عنوانك", style: Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: AppSize.s300,
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
                    color: ColorManager.white,
                    border: Border.all(
                      color: ColorManager.lightGrey,
                      width: 1,
                    ),
                  ),
                  dropDownPadding: const EdgeInsets.all(12),
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
                  selectedItemStyle: Theme.of(context).textTheme.headlineLarge,
                  dropdownHeadingStyle: Theme.of(context).textTheme.titleMedium,
                  dropdownItemStyle: Theme.of(context).textTheme.titleMedium,
                  dropdownDialogRadius: 10.0,
                  searchBarRadius: 10.0,
                  onStateChanged: (value) {
                    if (value != null) {
                      stateNameController.text = value;
                    }
                  },
                  onCityChanged: (value) {
                    if (value != null) {
                      districtController.text = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: "المنطقة",
                  controller: neighborhoodController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  icon: const Icon(Icons.my_location_outlined),
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
      ),
    );
  }

  my_stepper.Step fourthStep() {
    return my_stepper.Step(
      state: my_stepper.StepState.complete,
      isActive: _activeStepIndex >= 3,
      title: Text("تأكيد", style: Theme.of(context).textTheme.bodySmall),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: AppSize.s300,
        child: Column(
          children: [
            Wrap(
              runSpacing: 10.0,
              children: [
                buildDonorDetail(
                  key: "اسم المتبرع",
                  value: nameController.text,
                ),
                buildDonorDetail(
                  key: "رقم الهاتف",
                  value: phoneController.text,
                ),
                buildDonorDetail(
                  key: "فصيلة الدم",
                  value: bloodType ?? "غير محدد",
                ),
                buildDonorDetail(
                  key: "العنوان",
                  value:
                      '${stateNameController.text} - ${districtController.text} - ${neighborhoodController.text}',
                ),
                buildDonorDetail(
                  key: "البريد الإلكتروني",
                  value: emailController.text,
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
                          color: ColorManager.link,
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

  Icon _buildPasswordIcon() {
    return Icon(isPasswordVisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined);
  }

  Wrap buildDonorDetail({
    required String key,
    required String value,
  }) {
    return Wrap(
      runSpacing: 5.0,
      children: [
        Text(
          "$key:  ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(width: 30.0),
      ],
    );
  }
}
