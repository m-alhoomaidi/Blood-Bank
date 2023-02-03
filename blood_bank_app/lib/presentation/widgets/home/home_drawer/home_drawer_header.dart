import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manageer.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: ColorManager.lightPrimary,
      ),
      child: InkWell(
        onTap: () async {},
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: AppSize.s10),
              Container(
                height: AppSize.s80,
                width: AppSize.s80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r50),
                  color: ColorManager.white,
                ),
                child: const Center(
                  child: Icon(
                    Icons.emoji_emotions,
                    size: AppSize.s50,
                    color: ColorManager.lightSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s20),
              Wrap(
                children: [
                  Text(
                    (currentUser != null)
                        ? currentUser.email!
                        : AppStrings.homeDrawerHeaderAppName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
