import 'package:flutter/material.dart';

import '../../../models/compare_hive_firbaase.dart';
import 'home_drawer_header.dart';
import 'home_drower_body.dart';

class HomeDrower extends StatelessWidget {
  const HomeDrower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompareHiveAndFireStore().compareHiveAndFirestore();
    return Drawer(
      child: Column(
        children: const [
          HomeDrawerHeader(),
          // if user signed in show HomeDrawerUserBody
          HomeDrawerBody(),
        ],
      ),
    );
  }

  void selectMethodcompareHiveAndFirestore() async {}
}
