import 'package:blood_bank_app/pages/search_page.dart';
import 'package:blood_bank_app/pages/sign_up_page.dart';
import 'package:blood_bank_app/shared/style.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: const Image(
            image: AssetImage('assets/images/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          color: Colors.black54,
        ),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'ومن أحياها فكأنما أحيا الناس جميعاً',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                MyTextFormField(
                  hint: 'البحث عن متبرع',
                  icon: const Icon(Icons.search_rounded),
                  suffixIcon: false,
                  fillColor: Colors.white,
                  blurrBorderColor: eSecondColor.withOpacity(0),
                  focusBorderColor: eSecondColor.withOpacity(0),
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(SearchPage.routeName);
                  },
                ),
                MyButton(
                  title: 'إنشاء حساب متبرع',
                  color: eSecondColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
