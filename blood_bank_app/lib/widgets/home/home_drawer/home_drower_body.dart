import 'package:blood_bank_app/cubit/signin_cubit/signin_cubit.dart';
import 'package:blood_bank_app/dependecy_injection.dart' as di;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/profile_cubit/profile_cubit.dart';
import '../../../models/compare_hive_firbaase.dart';
import '../../../pages/setting_page.dart';
import '../../../pages/sign_in_page.dart';
import '../../../pages/sign_up_page.dart';
import '../../../presentation/resources/color_manageer.dart';
import '../../../shared/utils.dart';
import 'home_drawer_menu_item.dart';

class HomeDrawerBody extends StatelessWidget {
  const HomeDrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        children: [
          HomeDrawerMenuItem(
            title: "تسجيل دخول",
            icon: Icons.login_rounded,
            onTap: () {
              di.initSignIn();
              Navigator.of(context).pushNamed(SignInPage.routeName);
            },
          ),
          HomeDrawerMenuItem(
            title: "إنشاء حساب",
            icon: Icons.person_add_outlined,
            onTap: () {
              Navigator.of(context).pushNamed(SignUpPage.routeName);
            },
          ),
          HomeDrawerMenuItem(
            icon: Icons.settings_outlined,
            title: "إعدادات",
            onTap: () {
              // CompareHiveAndFireStore().compareHiveAndFirestore();

              BlocProvider.of<ProfileCubit>(context).getDataToProfilePage();
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.of(context).pushNamed(SettingPage.routeName);
              } else {
                Utils.showSnackBar(
                  context: context,
                  msg: "الرجاء تسجيل الدخول اولا",
                  color: ColorManager.error,
                );
                di.initSignIn();
                Navigator.of(context).pushNamed(SignInPage.routeName);
              }
            },
          ),
          const Divider(color: Colors.black54),
          HomeDrawerMenuItem(
            title: "حول التبيق",
            icon: Icons.info_outline,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
