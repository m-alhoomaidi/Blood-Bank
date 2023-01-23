import 'package:blood_bank_app/presentation/resources/assets_manager.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/constatns.dart';
import 'package:blood_bank_app/presentation/resources/font_manager.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/forms/my_button.dart';

import '../cubit/signin_cubit/signin_cubit.dart';
import '../models/dialod_reset_password.dart';
import '../pages/home_page.dart';
import '../pages/sign_up_page.dart';
import '../shared/utils.dart';
import '../widgets/forms/my_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const String routeName = "/sign-in";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  String? emailValidator(value) {
    if (value != null && EmailValidator.validate(value)) {
      return null;
    } else if (!EmailValidator.validate(value!)) {
      return AppStrings.signInEmailFieldValidatorError;
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value!.length < minCharsOfPassword) {
      return AppStrings.signInPasswordFieldValidatorError;
    }
    return null;
  }

  _toggleIsPasswordVisible() {
    setState(() => isPasswordVisible = !isPasswordVisible);
  }

  _sendRestPassword() {
    if (_emailState.currentState!.validate()) {
      BlocProvider.of<SingInCubit>(context)
          .resetPassword(email: emailController.text);
    }
  }

  _submitSignIn() async {
    // print("llllllllllllllllllllllllllllllllll");
    // print(emailController.text);
    // print(passwordController.text);
    // await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(
    //         email: emailController.text, password: passwordController.text)
    //     .then((value) {
    //   print(value);
    // }).onError((error, stackTrace) {
    //   print(error);
    // });
    if (_emailState.currentState!.validate() &
        _formState.currentState!.validate()) {
      BlocProvider.of<SingInCubit>(context).signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  _moveToSignUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signInAppBarTitle),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocConsumer<SingInCubit, SignInState>(
          listener: (context, state) {
            if (state is SigninSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else if (state is SigninFailure) {
              Utils.showSnackBar(
                context: context,
                msg: state.error,
                color: ColorManager.error,
              );
            } else if (state is SigninSuccessResetPass) {
              DialogResetPassWord.resetPasswordDialog(context);
              MaterialPageRoute(builder: (context) => const HomePage());
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: (state is SigninLoading),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSize.s30),
                    _buildHeaderImage(),
                    const SizedBox(height: AppSize.s20),
                    _buildSignInForm(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Form _buildSignInForm(BuildContext context) {
    return Form(
      key: _formState,
      child: Column(
        children: [
          _buildEmailField(context),
          const SizedBox(height: AppSize.s20),
          _buildPasswordField(context),
          _buildResetPasswordTextButton(context),
          const SizedBox(height: AppSize.s30),
          Column(
            children: [
              const SizedBox(width: AppSize.s50),
              _buildSubmitButton(context),
              const SizedBox(width: AppSize.s20),
              _buildSignUpButton(),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildHeaderImage() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Stack(
        children: const [
          SizedBox(
            height: signInImageHight,
            child: CircleAvatar(
              backgroundImage: AssetImage(ImageAssets.signInImage),
              radius: signInImageRadius,
            ),
          ),
          Positioned(
            bottom: AppSize.s8,
            right: AppSize.s0,
            child: Icon(
              Icons.add,
              size: AppSize.s70,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildEmailField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m40),
      child: Form(
        key: _emailState,
        child: MyTextFormField(
          hint: AppStrings.signInEmailFieldHint,
          controller: emailController,
          blurrBorderColor: ColorManager.lightGrey,
          focusBorderColor: ColorManager.secondary,
          fillColor: ColorManager.white,
          validator: emailValidator,
          icon: const Icon(Icons.phone_android),
        ),
      ),
    );
  }

  Container _buildPasswordField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: MyTextFormField(
        hint: AppStrings.signInPasswordFieldHint,
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
    );
  }

  Container _buildResetPasswordTextButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p50,
        vertical: AppPadding.p10,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _sendRestPassword,
        child: Text(
          AppStrings.signInForgetPasswordTextButton,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Icon _buildPasswordIcon() {
    return Icon(isPasswordVisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined);
  }

  MyButton _buildSubmitButton(BuildContext context) {
    return MyButton(
      title: AppStrings.signInSubmitButton,
      color: Theme.of(context).colorScheme.secondary,
      onPressed: _submitSignIn,
      minWidth: AppSize.s300,
    );
  }

  MyButton _buildSignUpButton() {
    return MyButton(
      title: AppStrings.signInSignUpButton,
      color: ColorManager.grey1,
      onPressed: _moveToSignUp,
      minWidth: AppSize.s300,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: FontSize.s14,
        fontFamily: FontConstants.fontFamily,
      ),
    );
  }
}

                                // forget password onTap 
                                // if (_formStateEmail.currentState!.validate()) {
                                // _formStateEmail.currentState!.save();
                                //   if (email!.isValidPhone) {
                                //     BlocProvider.of<SingInCubit>(context)
                                //         .isPhoneRegisterd(
                                //             phone: email!, type: "forget");
                                //   }

                                // signin button onPress
                                  // if (_formState.currentState!.validate() &&
                                  //     _formStateEmail.currentState!
                                  //         .validate()) {
                                  //   _formState.currentState!.save();
                                  //   _formStateEmail.currentState!.save();
                                  //   if (email!.isValidPhone) {
                                  //     BlocProvider.of<SingInCubit>(context)
                                  //         .isPhoneRegisterd(
                                  //             phone: email!,
                                  //             type: "signin",
                                  //             password: password!);
                                  //   } else {
                                  //     BlocProvider.of<SingInCubit>(context)
                                  //         .signIn(
                                  //             email: email!,
                                  //             password: password!);
                                  //   }
                                  // }