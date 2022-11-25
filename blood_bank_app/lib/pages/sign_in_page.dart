import 'dart:math';

import 'package:blood_bank_app/cubit/signin_cubit/signin_cubit.dart';
import 'package:blood_bank_app/models/extention.dart';
import 'package:blood_bank_app/widgets/method/dialod_reset_password.dart';
import 'package:blood_bank_app/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pages/sign_up_page.dart';
import '../utils.dart';
import '../widgets/forms/my_outlined_icon_button.dart';
import '../style.dart';
import '../widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  static const String routeName = "sign-in";

  // bool _saving = false;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formStateEmail = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل دخول'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocConsumer<SingInCubit, SignInState>(
          listener: (context, state) {
            if (state is SigninSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else if (state is SigninFailure) {
              Utils.showSnackBar(context: context, msg: state.error);
            } else if (state is SigninSuccessResetPass) {
              DialogResetPassWord.Dialog(context);
              // MaterialPageRoute(builder: (context) => const HomePage());
            }

            // TODO: implement listener
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: (state is SigninLoading),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/images/blood_drop.svg",
                            color: ePrimColor,
                            height: 100,
                          ),
                          const Positioned(
                            bottom: 7,
                            right: 0,
                            child: Icon(
                              Icons.add,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formState,
                      child: Column(
                        children: [
                          Form(
                            key: _formStateEmail,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: MyTextFormField(
                                hint: "رقم الهاتف أو البريد",
                                hintStyle: eHintStyle,
                                blurrBorderColor: Colors.white,
                                focusBorderColor: eTextFieldFocusBorder,
                                fillColor: eTextFieldFill,
                                keyBoardType: TextInputType.phone,
                                onSave: (value) {
                                  email = value;
                                },
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
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: MyTextFormField(
                              hint: "كلمة المرور",
                              hintStyle: eHintStyle,
                              isPassword: true,
                              blurrBorderColor: Colors.white,
                              focusBorderColor: eTextFieldFocusBorder,
                              fillColor: eTextFieldFill,
                              onSave: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value!.length < 6) {
                                  return "يجب أن يكون طول كلمة المرور ستة أو أكثر";
                                }
                                return null;
                              },
                              icon: const Icon(Icons.key_outlined),
                            ),
                          ),
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
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                if (_formStateEmail.currentState!.validate()) {
                                  _formStateEmail.currentState!.save();
                                  if (email!.isValidPhone) {
                                    BlocProvider.of<SingInCubit>(context)
                                        .isPhoneRegisterd(
                                            phone: email!, type: "forget");
                                  } else {
                                    BlocProvider.of<SingInCubit>(context)
                                        .resetPassword(email: email!);
                                  }
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 50.0),
                              const Text(
                                "ليس لديك حساب؟  ",
                              ),
                              GestureDetector(
                                child: const Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignUpPage.routeName);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    MyOutlinedIconButton(
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          "تسجيل دخول",
                          style: TextStyle(
                            fontSize: 18,
                            color: eSecondColor,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formState.currentState!.validate() &&
                            _formStateEmail.currentState!.validate()) {
                          _formState.currentState!.save();
                          _formStateEmail.currentState!.save();
                          if (email!.isValidPhone) {
                            BlocProvider.of<SingInCubit>(context)
                                .isPhoneRegisterd(
                                    phone: email!,
                                    type: "signin",
                                    password: password!);
                          } else {
                            BlocProvider.of<SingInCubit>(context)
                                .signIn(email: email!, password: password!);
                          }
                        }
                      },
                      borderColor: eSecondColor,
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
