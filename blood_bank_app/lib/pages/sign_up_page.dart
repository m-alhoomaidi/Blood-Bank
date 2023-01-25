import 'package:blood_bank_app/presentation/resources/assets_manager.dart';
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
  bool isPasswordHidden = true;
  bool isFirstStep() => _activeStepIndex == 0;
  bool isLastStep() => _activeStepIndex == stepList().length - 1;

  Future<void> _submit() async {
    FormState? formData = _fourthFormState.currentState;
    if (formData!.validate()) {
      Donor newDonor = Donor(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
        bloodType: bloodType!,
        state: stateNameController.text,
        district: districtController.text,
        neighborhood: neighborhoodController.text,
      );
      BlocProvider.of<SignUpCubit>(context).signUpDonor(
        donor: newDonor,
      );
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
        title: const Text(AppStrings.signUpAppBarTitle),
      ),
      body: BlocConsumer<SignUpCubit, SignupState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Utils.showSuccessSnackBar(
                context: context, msg: AppStrings.signUpSuccessMessage);
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          } else if (state is SignUpFailure) {
            Utils.showFalureSnackBar(context: context, msg: state.error);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: (state is SignupLoading),
            child: my_stepper.Stepper(
              svgPictureAsset: ImageAssets.bloodDrop,
              iconColor: Theme.of(context).primaryColor,
              elevation: AppSize.s0,
              type: my_stepper.StepperType.horizontal,
              currentStep: _activeStepIndex,
              steps: stepList(),
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              onStepTapped: _onStepTapped,
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
    BuildContext context,
    my_stepper.ControlsDetails controls,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: AppSize.s60,
              ),
              if (!isFirstStep())
                Positioned(
                  right: AppSize.s20,
                  child: SizedBox(
                    width: AppSize.s140,
                    child: MyOutlinedIconButton(
                      onPressed: controls.onStepCancel,
                      borderColor: Theme.of(context).primaryColor,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        AppStrings.signUpPreviousButton,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: AppSize.s20),
              Positioned(
                left: AppSize.s20,
                child: SizedBox(
                  width: AppSize.s140,
                  child: (isLastStep())
                      ? MyOutlinedIconButton(
                          icon: Text(
                            AppStrings.signUpCreateButton,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: ColorManager.success),
                          ),
                          label: const Icon(
                            Icons.check_rounded,
                            color: ColorManager.success,
                          ),
                          onPressed: _submit,
                          borderColor: ColorManager.success,
                        )
                      : MyOutlinedIconButton(
                          icon: Text(
                            AppStrings.signUpNextButton,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          label: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: _validateForm,
                          borderColor: Theme.of(context).colorScheme.secondary,
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
                    onPressed: _moveToSignUpAsCenter,
                    child: Text(
                      AppStrings.signUpAsCenterLink,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: ColorManager.link),
                    ),
                  ),
                )
              : const SizedBox(),
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
      title: Text(AppStrings.signUpFirstStepTitle,
          style: _activeStepIndex >= 0
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).primaryColor)
              : Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: signUpStepHight,
        child: Form(
          key: _firstFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.signUpFirstStepMotivationPhrase,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSize.s40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                child: MyTextFormField(
                  hint: AppStrings.signUpEmailHint,
                  controller: emailController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: _emailValidator,
                  icon: const Icon(Icons.email),
                  keyBoardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: signUpSpaceBetweenFields),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFormField(
                  hint: AppStrings.signUpPasswordHint,
                  controller: passwordController,
                  isPassword: isPasswordHidden,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: _passwordValidator,
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
      title: Text(AppStrings.signUpSecondStepTitle,
          style: _activeStepIndex >= 1
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).primaryColor)
              : Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: signUpStepHight,
        child: Form(
          key: _secondFormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                child: MyTextFormField(
                  hint: AppStrings.signUpNameHint,
                  controller: nameController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: _nameValidator,
                  icon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: signUpSpaceBetweenFields),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                child: MyTextFormField(
                  hint: AppStrings.signUpPhoneHint,
                  controller: phoneController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  validator: _phoneNumberValidator,
                  icon: const Icon(Icons.phone_android),
                  keyBoardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: signUpSpaceBetweenFields),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                child: MyDropdownButtonFormField(
                  hint: AppStrings.signUpBloodTypeHint,
                  validator: _bloodTypeValidator,
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
      title: Text(AppStrings.signUpThirdStepTitle,
          style: _activeStepIndex >= 2
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).primaryColor)
              : Theme.of(context).textTheme.bodySmall),
      content: SizedBox(
        height: signUpStepHight,
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
                  dropDownPadding: const EdgeInsets.all(AppPadding.p12),
                  spaceBetween: signUpSpaceBetweenFields,
                  disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: ColorManager.grey1,
                    border: Border.all(
                      color: ColorManager.grey1,
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
                  dropdownDialogRadius: AppRadius.r10,
                  searchBarRadius: AppRadius.r10,
                  onStateChanged: _onStateChange,
                  onCityChanged: _onCityChanged,
                ),
              ),
              const SizedBox(height: signUpSpaceBetweenFields),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                child: MyTextFormField(
                  hint: AppStrings.signUpNeighborhoodHint,
                  controller: neighborhoodController,
                  blurrBorderColor: ColorManager.lightGrey,
                  focusBorderColor: ColorManager.secondary,
                  fillColor: ColorManager.white,
                  icon: const Icon(Icons.my_location_outlined),
                  validator: _neighborhoodValidator,
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
      title: Text(AppStrings.signUpFourthStepTitle,
          style: _activeStepIndex >= 3
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).primaryColor)
              : Theme.of(context).textTheme.bodySmall),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        height: signUpStepHight,
        child: Column(
          children: [
            Wrap(
              runSpacing: AppSize.s16,
              alignment: WrapAlignment.center,
              children: [
                buildDonorDetail(
                  key: AppStrings.signUpConfirmNameLabel,
                  value: nameController.text,
                ),
                buildDonorDetail(
                  key: AppStrings.signUpConfirmPhoneLabel,
                  value: phoneController.text,
                ),
                buildDonorDetail(
                  key: AppStrings.signUpConfirmBloodTypeLabel,
                  value: bloodType ?? AppStrings.unDefined,
                ),
                buildDonorDetail(
                  key: AppStrings.signUpConfirmAddressLabel,
                  value:
                      '${stateNameController.text} - ${districtController.text} - ${neighborhoodController.text}',
                ),
                buildDonorDetail(
                  key: AppStrings.signUpConfirmEmailLabel,
                  value: emailController.text,
                ),
              ],
            ),
            Form(
              key: _fourthFormState,
              child: MyCheckboxFormField(
                title: Row(
                  children: [
                    const Text(AppStrings.signUpIConfirmThat),
                    GestureDetector(
                      onTap: _moveToPrivacyPolicyPage,
                      child: Text(
                        AppStrings.signUpPrivacyPolicy,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: ColorManager.link),
                      ),
                    ),
                  ],
                ),
                onSaved: (value) {},
                validator: _confirmValidator,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateForm({int? stepIndex}) {
    FormState? formData = currentFormState();
    if (_activeStepIndex == 2 && districtController.text == "") {
      Fluttertoast.showToast(msg: AppStrings.signUpStateCityValidator);
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

  void _onStepTapped(int index) {
    _validateForm(stepIndex: index);
  }

  void _onStepCancel() {
    if (isFirstStep()) {
      return;
    }
    setState(() => _activeStepIndex -= 1);
  }

  void _onStepContinue() {
    if (_activeStepIndex < (stepList().length - 1)) {
      setState(() {
        _activeStepIndex += 1;
      });
    }
  }

  String? _confirmValidator(value) =>
      !value! ? AppStrings.signUpYouHaveToConfirm : null;

  Icon _buildPasswordIcon() {
    return Icon(isPasswordHidden
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

  _toggleIsPasswordVisible() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }

  String? _emailValidator(value) =>
      value != null && EmailValidator.validate(value)
          ? null
          : AppStrings.signUpEmailValidator;

  String? _passwordValidator(value) => (value!.length < minCharsOfPassword)
      ? AppStrings.firebasePasswordValidatorError
      : null;

  String? _nameValidator(String? value) =>
      (value!.length < minCharsOfName) ? AppStrings.signUpNameValidator : null;

  String? _bloodTypeValidator(value) =>
      (value == null) ? AppStrings.signUpBloodTypeValidator : null;

  String? _phoneNumberValidator(String? value) {
    String pattern = r"^\+?7[0|1|3|7|8][0-9]{7}$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return AppStrings.signUpPhoneValidator;
    } else {
      return null;
    }
  }

  String? _neighborhoodValidator(value) {
    if (value!.length < 2) {
      return AppStrings.signUpNeighborhoodValidator;
    }
    return null;
  }

  void _onCityChanged(value) {
    if (value != null) {
      districtController.text = value;
    }
  }

  void _onStateChange(value) {
    if (value != null) {
      stateNameController.text = value;
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

  void _moveToSignUpAsCenter() {
    Navigator.of(context).pushReplacementNamed(SignUpCenter.routeName);
  }

  void _moveToPrivacyPolicyPage() {}
}
