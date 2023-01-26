import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils.dart';
import '../../../../cubit/profile_cubit/profile_cubit.dart';
import '../../../../dependency_injection.dart' as di;
import '../../../pages/setting_page.dart';
import '../../../pages/sign_in_page.dart';
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
