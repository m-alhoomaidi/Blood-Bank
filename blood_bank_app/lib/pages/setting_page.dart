import 'package:blood_bank_app/widgets/setting/profile_body.dart';
import 'package:flutter/material.dart';

import '../widgets/setting/display_image.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = "setting";
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting Page'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          InkWell(
              onTap: () {},
              child: DisplayImage(
                imagePath: 'assets/images/1.jpg',
                onPressed: () {},
              )),
          const SizedBox(
            height: 10,
          ),
          const ProfileBody(),
        ]));
  }
}
