import 'package:blood_bank_app/dependecy_injection.dart' as di;
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/profile_cubit/profile_cubit.dart';
import '../../../pages/setting_page.dart';
import '../../../pages/sign_in_page.dart';
import '../../../pages/sign_up_page.dart';
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
            title: AppStrings.homeDrawerSignIn,
            icon: Icons.login_rounded,
            onTap: () {
              di.initSignIn();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInPage(),
                ),
              );
            },
          ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerSignUp,
            icon: Icons.person_add_outlined,
            onTap: () {
              di.initSignUp();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignUpPage(),
                ),
              );
            },
          ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerSettings,
            icon: Icons.settings_outlined,
            onTap: () {
              // CompareHiveAndFireStore().compareHiveAndFirestore();
              di.initProfile();
              BlocProvider.of<ProfileCubit>(context).getDataToProfilePage();
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingPage(),
                  ),
                );
              } else {
                Utils.showSnackBar(
                  context: context,
                  msg: AppStrings.homeDrawerSignInFirstToast,
                );
                di.initSignIn();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInPage(),
                  ),
                );
              }
            },
          ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerUpdateBloodBank,
            icon: Icons.sync,
            onTap: () {},
          ),
          const Divider(color: Colors.black54),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerAboutApp,
            icon: Icons.info_outline,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const ProfileCenterPage(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
