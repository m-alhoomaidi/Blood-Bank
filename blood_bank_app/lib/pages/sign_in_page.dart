import 'package:blood_bank_app/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  static const String routeName = "sign-in";

  bool _saving = false;
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل دخول'),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
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
              const SizedBox(height: 40),
              Form(
                key: _formState,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyTextFormField(
                          hint: "رقم الهاتف",
                          blurrBorderColor: Colors.white,
                          focusBorderColor: eTextFiledFocusBorder,
                          fillColor: eTextFiledFill,
                          keyBoardType: TextInputType.phone,
                          onSave: (value) {},
                          validator: (value) =>
                              value != null && EmailValidator.validate(value)
                                  ? null
                                  : "اكتب بريد إيميل صحيح",
                          icon: Icons.phone_android),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: MyTextFormField(
                        hint: "كلمة المرور",
                        isPassword: true,
                        blurrBorderColor: Colors.white,
                        focusBorderColor: eTextFiledFocusBorder,
                        fillColor: eTextFiledFill,
                        onSave: (value) {},
                        validator: (value) {
                          if (value!.length < 6) {
                            return "يجب أن يكون طول كلمة المرور ستة أو أكثر";
                          }
                          return null;
                        },
                        icon: Icons.key_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                title: "تسجيل دخول",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}