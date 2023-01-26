import 'package:flutter/material.dart';

import 'home_drawer_header.dart';
import 'home_drower_body.dart';

class HomeDrower extends StatelessWidget {
  const HomeDrower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          HomeDrawerHeader(),
          // TODO if is user show HomeDrawerUserBody(),
          HomeDrawerBody(),
        ],
      ),
    );
  }
}
