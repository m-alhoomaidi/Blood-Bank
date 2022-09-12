import 'package:blood_bank_app/pages/sign_in_page.dart';
import 'package:blood_bank_app/pages/sign_up_page.dart';
import 'package:blood_bank_app/style.dart';
import 'package:flutter/material.dart';

class HomeDrower extends StatelessWidget {
  const HomeDrower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          buildDrawerHeader(context),
          buildDrawerMenu(context),
        ],
      ),
    );
  }

  DrawerHeader buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () {
          // Navigator.pop(context);
          // Navigator.of(context).pushNamed(ProfilePage.routeName);
        },
        child: Center(
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Icon(
                    Icons.emoji_emotions,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "اسم المستخدم",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDrawerMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        children: [
          buildDrawerMenuItem(
            context: context,
            icon: Icons.home_outlined,
            title: "الرئيسية",
            onTap: () {},
          ),
          buildDrawerMenuItem(
            context: context,
            title: "تسجيل دخول",
            icon: Icons.login_rounded,
            onTap: () {
              Navigator.of(context).pushNamed(SignInPage.routeName);
            },
          ),
          buildDrawerMenuItem(
            context: context,
            title: "إنشاء حساب",
            icon: Icons.person_add_outlined,
            onTap: () {
              Navigator.of(context).pushNamed(SignUpPage.routeName);
            },
          ),
          buildDrawerMenuItem(
            context: context,
            icon: Icons.settings_outlined,
            title: "إعدادات",
            onTap: () {},
          ),
          const Divider(color: Colors.black54),
          buildDrawerMenuItem(
            context: context,
            title: "حول التبيق",
            icon: Icons.info_outline,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Container buildDrawerUserMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        children: [
          buildDrawerMenuItem(
            context: context,
            icon: Icons.home_outlined,
            title: "Home",
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              // Navigator.of(context).pushNamed(MakingForm.routeName);
              // Navigator.of(context).pushNamed(TestLock.routeName);
            },
          ),
          buildDrawerMenuItem(
            context: context,
            title: "Settings",
            icon: Icons.settings_outlined,
            onTap: () {
              // Navigator.pop(context);
              // Navigator.of(context).pushNamed(SettingsPage.routeName);
            },
          ),
          buildDrawerMenuItem(
            context: context,
            title: "My Qaradeh",
            icon: Icons.dashboard,
            onTap: () {
              // Navigator.pop(context);
              // Navigator.of(context).pushNamed(MyQaradehPage.routeName);
            },
          ),
          const Divider(color: Colors.black54),
          buildDrawerMenuItem(
            context: context,
            title: "About" "About",
            icon: Icons.info_outline,
            onTap: () {
              // Navigator.of(context).pushNamed(AboutPage.routeName);
            },
          ),
          buildDrawerMenuItem(
            context: context,
            title: "Log Out",
            icon: Icons.login_rounded,
            onTap: () async {
              // Navigator.pop(context);
              // if (currentUser != null) {
              //   await FirebaseAuth.instance.signOut();
              //   currentUser = null;
              // }
              // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
