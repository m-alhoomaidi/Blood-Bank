import 'package:blood_bank_app/presentation/resources/assets_manager.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/constatns.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';

import '../widgets/forms/my_button.dart';

import '../cubit/signin_cubit/signin_cubit.dart';
import '../models/extention.dart';
import '../models/dialod_reset_password.dart';
import '../pages/home_page.dart';
import '../pages/sign_up_page.dart';
import '../shared/utils.dart';
import '../shared/style.dart';
import '../widgets/forms/my_text_form_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);
  static const String routeName = "sign-in";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // bool _saving = false;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailState = GlobalKey<FormState>();

  // final GlobalKey<FormState> _formStateEmail = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p10),
                      child: Stack(
                        children: const [
                          SizedBox(
                            height: signInImageHight,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage(ImageAssets.signInImage),
                              radius: signInImageRadius,
                            ),
                          ),
                          Positioned(
                            bottom: AppSize.s8,
                            right: AppSize.s0,
                            child: Icon(
                              Icons.add,
                              size: AppSize.s70,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    Form(
                      key: _formState,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppMargin.m40),
                            child: Form(
                              key: _emailState,
                              child: MyTextFormField(
                                hint: AppStrings.signInEmailFieldHint,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium!,
                                blurrBorderColor: ColorManager.grey,
                                focusBorderColor: ColorManager.lightPrimary,
                                fillColor: ColorManager.white,
                                validator: (value) {
                                  if (value != null &&
                                      EmailValidator.validate(value)) {
                                    return null;
                                  } else if (value!.isValidPhone) {
                                    return null;
                                  } else if (!EmailValidator.validate(value) ||
                                      !value.isValidPhone) {
                                    return "اكتب بريد إيميل او رقم هاتف صحيح";
                                  }
                                  return null;
                                },
                                icon: const Icon(Icons.phone_android),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: MyTextFormField(
                              hint: "كلمة المرور",
                              hintStyle: eHintStyle,
                              isPassword: true,
                              blurrBorderColor: eFieldBlurrBorderColor,
                              focusBorderColor: eFieldFocusBorderColor,
                              fillColor: eFieldFillColor,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return "يجب أن يكون طول كلمة المرور ستة أو أكثر";
                                }
                                return null;
                              },
                              icon: const Icon(Icons.key_outlined),
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50.0,
                              vertical: 10.0,
                            ),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: const Text(
                                "نسيت كلمة المرور؟",
                                style: TextStyle(
                                  // color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                if (_emailState.currentState!.validate()) {
                                  BlocProvider.of<SingInCubit>(context)
                                      .resetPassword(
                                          email: emailController.text);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Row(
                            children: [
                              const SizedBox(width: 50.0),
                              MyButton(
                                title: "الدخول",
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_emailState.currentState!.validate() &
                                      _formState.currentState!.validate()) {
                                    BlocProvider.of<SingInCubit>(context)
                                        .signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                minWidth: 150,
                              ),
                              const SizedBox(width: 20),
                              MyButton(
                                title: "إنشاء حساب",
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignUpPage.routeName);
                                },
                                minWidth: 150,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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