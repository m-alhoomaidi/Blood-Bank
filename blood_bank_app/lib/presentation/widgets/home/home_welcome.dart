import 'package:blood_bank_app/presentation/pages/search_page.dart';
import 'package:blood_bank_app/presentation/pages/setting_page.dart';
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
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
          // child: const Image(
          //   image: AssetImage('assets/images/1.jpg'),
          //   fit: BoxFit.cover,
          // ),
        ),
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          // color: ColorManager.grey1,
        ),
        SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'مرحباً',
                //   style: Theme.of(context).textTheme.displayLarge,
                // ),
                Text(
                  'ومن أحياها\n فكأنما أحيا الناس جميعاً',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(height: 1.5),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.grey.withOpacity(0.4),
                          blurRadius: 2.0,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: MyTextFormField(
                    hint: 'البحث عن متبرع',
                    icon: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: false,
                    fillColor: ColorManager.grey1,
                    blurrBorderColor: eSecondColor.withOpacity(0),
                    focusBorderColor: eSecondColor.withOpacity(0),
                    hintStyle:
                        Theme.of(context).textTheme.bodyLarge as TextStyle,
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
                ),
                userType == "0"
                    ? MyButton(
                        title: 'إنشاء حساب متبرع',
                        color: Theme.of(context).primaryColor,
                        titleStyle: Theme.of(context).textTheme.titleLarge,
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
