import 'home_drawer_menu_item.dart';

import 'package:flutter/material.dart';

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
            icon: Icons.home_outlined,
            title: "Home",
            onTap: () {},
          ),
          HomeDrawerMenuItem(
            title: "Settings",
            icon: Icons.settings_outlined,
            onTap: () {},
          ),
          HomeDrawerMenuItem(
            title: "My Qaradeh",
            icon: Icons.dashboard,
            onTap: () {},
          ),
          const Divider(color: Colors.black54),
          HomeDrawerMenuItem(
            title: "About" "About",
            icon: Icons.info_outline,
            onTap: () {},
          ),
          HomeDrawerMenuItem(
            title: "Log Out",
            icon: Icons.login_rounded,
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
