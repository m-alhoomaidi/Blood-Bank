// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/domain/entities/blood_center.dart';
import 'package:blood_bank_app/pages/edit_main_data_page.dart';
import 'package:blood_bank_app/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:blood_bank_app/dependecy_injection.dart' as di;
import 'package:blood_bank_app/presentation/resources/color_manageer.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileCenterPage extends StatefulWidget {
  static const String routeName = "profileCenter";
  ProfileCenterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCenterPage> createState() => _ProfileCenterPageState();
}

class _ProfileCenterPageState extends State<ProfileCenterPage> {
  ProfileCenterData? profileCenterDataa;

  getProfileCenterData() async {
    di.initSignIn();
    await BlocProvider.of<ProfileCubit>(context).getProfileCenterData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProfileCenterData();
    profileCenterDataa = ProfileCenterData(
        aPlus: 5,
        aMinus: 5,
        abPlus: 5,
        abMinus: 5,
        oPlus: 5,
        oMinus: 5,
        bPlus: 5,
        bMinus: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileAppBarTitle),
        elevation: 0,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileGetCenterData) {
            profileCenterDataa = ProfileCenterData(
                aPlus: state.bloodCenter.aPlus,
                aMinus: state.bloodCenter.aMinus,
                abPlus: state.bloodCenter.abPlus,
                abMinus: state.bloodCenter.bMinus,
                oPlus: state.bloodCenter.oPlus,
                oMinus: state.bloodCenter.oMinus,
                bPlus: state.bloodCenter.bPlus,
                bMinus: state.bloodCenter.bMinus);
          } else if (state is ProfileFailure) {
            Utils.showSnackBar(
              context: context,
              msg: state.error,
              color: ColorManager.error,
            );
          } else if (state is ProfileSuccess) {
            Utils.showSnackBar(
              context: context,
              msg: AppStrings.profileSuccesMess,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileGetCenterData) {
            profileCenterDataa = ProfileCenterData(
                aPlus: state.bloodCenter.aPlus,
                aMinus: state.bloodCenter.aMinus,
                abPlus: state.bloodCenter.abPlus,
                abMinus: state.bloodCenter.bMinus,
                oPlus: state.bloodCenter.oPlus,
                oMinus: state.bloodCenter.oMinus,
                bPlus: state.bloodCenter.bPlus,
                bMinus: state.bloodCenter.bMinus);

            return ModalProgressHUD(
              inAsyncCall: (state is ProfileLoading),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "فصائل الدم المتوفرة",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrfileCenterBloodTypeCard(
                      profileCenterData: profileCenterDataa!,
                      bloodType: BloodCenterField.aPlus,
                    ),
                    PrfileCenterBloodTypeCard(
                        profileCenterData: profileCenterDataa!,
                        bloodType: BloodCenterField.abPlus),
                    PrfileCenterBloodTypeCard(
                        profileCenterData: profileCenterDataa!,
                        bloodType: BloodCenterField.abMinus),
                    PrfileCenterBloodTypeCard(
                        profileCenterData: profileCenterDataa!,
                        bloodType: BloodCenterField.bPlus),
                    PrfileCenterBloodTypeCard(
                        profileCenterData: profileCenterDataa!,
                        bloodType: BloodCenterField.bMinus),
                    PrfileCenterBloodTypeCard(
                        profileCenterData: profileCenterDataa!,
                        bloodType: BloodCenterField.oMinus),
                    const SizedBox(
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PrfileCenterBloodTypeCard extends StatefulWidget {
  PrfileCenterBloodTypeCard(
      {Key? key, required this.profileCenterData, required this.bloodType})
      : super(key: key);
  ProfileCenterData profileCenterData;
  String bloodType;

  @override
  State<PrfileCenterBloodTypeCard> createState() =>
      _PrfileCenterBloodTypeCardState();
}

class _PrfileCenterBloodTypeCardState extends State<PrfileCenterBloodTypeCard> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = ProfileCenterData.getProfileCenterDataBlodTyeb(
            widget.bloodType, widget.profileCenterData)
        .toString();
  }

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
              SizedBox(
                width: 65,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0, right: 10.0),
                  child: Text(
                    "${widget.bloodType}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: ColorManager.primary),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 8,
                ),
                child: SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ProfileCenterData.getProfileCenterDataBlodTyeb(
                            BloodCenterField.aPlus, widget.profileCenterData);
                        widget.profileCenterData.aPlus =
                            (widget.profileCenterData.aPlus)! + 1;
                        _controller.text =
                            widget.profileCenterData.aPlus.toString();
                        print("++++++++++++++++++++");
                        print(widget.profileCenterData.aPlus);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.primary),
                      elevation: MaterialStateProperty.all(5),
                      shadowColor:
                          MaterialStateProperty.all(ColorManager.primary),
                    ),
                    // icon: Icon(Icons.plus_one)
                    child: const Icon(Icons.add),
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
                    // initialValue: "${widget.profileCenterData.aPlus}",
                    controller: _controller,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 8,
                ),
                child: SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ProfileCenterData.getProfileCenterDataBlodTyeb(
                            BloodCenterField.aPlus, widget.profileCenterData);
                        widget.profileCenterData.aPlus =
                            (widget.profileCenterData.aPlus)! - 1;
                        _controller.text =
                            widget.profileCenterData.aPlus.toString();
                        print("++++++++++++++++++++");
                        print(widget.profileCenterData.aPlus);
                      });
                    },
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

class ProfileCenterData {
  int? aPlus;
  int? aMinus;
  int? bPlus;
  int? bMinus;
  int? abPlus;
  int? abMinus;
  int? oPlus;
  int? oMinus;

  ProfileCenterData({
    this.aPlus,
    this.aMinus,
    this.bPlus,
    this.bMinus,
    this.abPlus,
    this.abMinus,
    this.oPlus,
    this.oMinus,
  });
  static getProfileCenterDataBlodTyeb(
      String bloodType, ProfileCenterData profileCenterData) {
    switch (bloodType) {
      case BloodCenterField.aPlus:
        return profileCenterData.aPlus;
      case BloodCenterField.aMinus:
        return profileCenterData.aMinus;
      case BloodCenterField.abPlus:
        return profileCenterData.abPlus;
      case BloodCenterField.abMinus:
        return profileCenterData.abMinus;
      case BloodCenterField.oPlus:
        return profileCenterData.oPlus;
      case BloodCenterField.oMinus:
        return profileCenterData.oMinus;
      case BloodCenterField.bPlus:
        return profileCenterData.bPlus;
      case BloodCenterField.bMinus:
        return profileCenterData.bMinus;
    }
  }
}
