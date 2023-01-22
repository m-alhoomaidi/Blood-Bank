import 'package:flutter/material.dart';

import '../../pages/search_page.dart';
import '../../pages/sign_up_page.dart';
import '../../shared/style.dart';
import '../forms/my_button.dart';
import '../forms/my_text_form_field.dart';

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
                Text(
                  'مرحباً',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'ومن أحياها فكأنما أحيا الناس جميعاً',
                  style: Theme.of(context).textTheme.displaySmall,
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
