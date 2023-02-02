import 'package:blood_bank_app/presentation/pages/search_page.dart';
import 'package:blood_bank_app/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../dependency_injection.dart' as di;
import '../../pages/sign_up_page.dart';
import '../../resources/style.dart';
import '../forms/my_button.dart';
import '../forms/my_text_form_field.dart';

class HomeWelcome extends StatefulWidget {
  const HomeWelcome({Key? key}) : super(key: key);

  @override
  State<HomeWelcome> createState() => _HomeWelcomeState();
}

class _HomeWelcomeState extends State<HomeWelcome> {
  String userType = "0";

  void checkUserType() {
    setState(() => userType = Hive.box(dataBoxName).get('user') ?? "0");
    super.initState();
  }

  @override
  void initState() {
    checkUserType();
    super.initState();
  }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchPage(),
                      ),
                    );
                  },
                ),
                userType == "1"
                    ? MyButton(
                        title: 'إنشاء حساب متبرع',
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          di.initSignUp();
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
