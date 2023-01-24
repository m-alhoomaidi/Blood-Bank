import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/dependecy_injection.dart' as di;
import 'package:blood_bank_app/pages/setting_page.dart';
import 'package:blood_bank_app/pages/sign_in_page.dart';
import 'package:blood_bank_app/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_drawer_menu_item.dart';

class HomeDrawerUserBody extends StatelessWidget {
  const HomeDrawerUserBody({
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
            icon: Icons.settings_outlined,
            title: "إعدادات",
            onTap: () {
              // CompareHiveAndFireStore().compareHiveAndFirestore();
              di.initProfile();
              BlocProvider.of<ProfileCubit>(context).getDataToProfilePage();
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.of(context).pushNamed(SettingPage.routeName);
              } else {
                Utils.showSnackBar(
                  context: context,
                  msg: "الرجاء تسجيل الدخول اولا",
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
