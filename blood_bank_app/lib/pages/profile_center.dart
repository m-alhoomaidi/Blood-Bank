import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:flutter/material.dart';

class ProfileCenterPage extends StatefulWidget {
  static const String routeName = "profileCenter";
  const ProfileCenterPage({super.key});

  @override
  State<ProfileCenterPage> createState() => _ProfileCenterPageState();
}

class _ProfileCenterPageState extends State<ProfileCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileAppBarTitle),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            PrfileCenterBloodTypeCard(),
            SizedBox(
              height: 20,
            ),
            MyButton(
              title: "Save",
              onPressed: () {},
              minWidth: 300,
              color: ColorManager.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class PrfileCenterBloodTypeCard extends StatelessWidget {
  const PrfileCenterBloodTypeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          color: ColorManager.white,
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 10, right: 10.0),
                child: Text(
                  "A+",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: ColorManager.primary),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15,
                ),
                child: SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.primary),
                      elevation: MaterialStateProperty.all(5),
                      shadowColor:
                          MaterialStateProperty.all(ColorManager.primary),
                    ),
                    // icon: Icon(Icons.plus_one)
                    child: const Icon(Icons.plus_one),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 15, right: 10.0),
                child: SizedBox(
                  width: 80,
                  height: 35,
                  child: TextFormField(
                    initialValue: "80",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 15,
                ),
                child: SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.primary),
                      alignment: Alignment.topCenter,
                      elevation: MaterialStateProperty.all(5),
                      shadowColor:
                          MaterialStateProperty.all(ColorManager.primary),
                    ),
                    // icon: Icon(Icons.plus_one)
                    child: const Icon(Icons.minimize),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfileCenterData {}
