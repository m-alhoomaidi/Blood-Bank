import 'package:blood_bank_app/core/utils.dart';
import 'package:blood_bank_app/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/presentation/pages/setting_page.dart';
import 'package:blood_bank_app/presentation/pages/sign_in_page.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'home_drawer_menu_item.dart';

class HomeDrawerDonorBody extends StatelessWidget {
  const HomeDrawerDonorBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        children: [
          // HomeDrawerMenuItem(
          //   icon: Icons.settings_outlined,
          //   title: "إعدادات",
          //   onTap: () {
          //     print("++++++++++++++++++");
          //   },
          // ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerSettings,
            icon: Icons.settings_outlined,
            onTap: () {
              print("++++++++++++++++++0");
              BlocProvider.of<ProfileCubit>(context).getDataToProfilePage();
              if (FirebaseAuth.instance.currentUser != null) {
                print("+0000");
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingPage(),
                  ),
                );
              } else {
                print("object");
                Utils.showSnackBar(
                  context: context,
                  msg: AppStrings.homeDrawerSignInFirstToast,
                );
                // divide.initSignIn();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInPage(),
                  ),
                );
              }
            },
          ),
          const Divider(color: Colors.black54),
          HomeDrawerMenuItem(
            title: "حول التبيق",
            icon: Icons.info_outline,
            onTap: () {},
          ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerLogOut,
            icon: Icons.logout_outlined,
            onTap: () async {
              Hive.box(dataBoxName).put('user', "0");
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
