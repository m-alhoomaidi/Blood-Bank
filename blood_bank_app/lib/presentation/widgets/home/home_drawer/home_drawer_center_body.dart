import 'package:blood_bank_app/presentation/pages/setting_page.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home_drawer_menu_item.dart';

class HomeDrawerCenterBody extends StatelessWidget {
  const HomeDrawerCenterBody({
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
            title: AppStrings.homeDrawerUpdateBloodBank,
            icon: Icons.sync,
            onTap: () {},
          ),
          HomeDrawerMenuItem(
            title: AppStrings.homeDrawerEditProfileCenter,
            icon: Icons.sync,
            onTap: () {},
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
