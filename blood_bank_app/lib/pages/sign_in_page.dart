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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formState,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                        hint: "رقم الهاتف",
                        blurrBorderColor: Colors.white,
                        focusBorderColor: Colors.pink[200],
                        fillColor: Colors.red[100],
                        keyBoardType: TextInputType.phone,
                        onSave: (value) {},
                        validator: (value) {
                          if (value!.length < 2) {
                            return "لا يمكن أن يكون الاسم أقل من حرفين";
                          }
                          return null;
                        },
                        icon: Icons.phone_android),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextFormField(
                      hint: "كلمة المرور",
                      isPassword: true,
                      blurrBorderColor: Colors.white,
                      focusBorderColor: Colors.pink[200],
                      fillColor: Colors.red[100],
                      onSave: (value) {},
                      validator: (value) {
                        if (value!.length != 9) {
                          return "يجب أن يكون عدد الأرقام 9";
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
    );
  }
}
