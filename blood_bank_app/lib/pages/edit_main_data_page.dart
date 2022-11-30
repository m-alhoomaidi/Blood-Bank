import 'package:blood_bank_app/pages/setting_page.dart';
import 'package:blood_bank_app/widgets/edit_main_data/address.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/edit_main_data/blood_type.dart';

class EditMainDataPage extends StatefulWidget {
  const EditMainDataPage({super.key});
  static const String routeName = "edit_main_data";

  @override
  State<EditMainDataPage> createState() => _EditMainDataPageState();
}

class _EditMainDataPageState extends State<EditMainDataPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _formStateBloodType = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("تعديل البيانات الاساسية"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box(dataBoxName).listenable(),
              builder: (context, box, widget) {
                return ListView(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("الاسم"),
                    ),
                    Form(
                      key: _formState,
                      child: MyTextFormField(
                        initialValue:
                            (box.get("name") == null) ? null : box.get("name"),
                        validator: (value) {
                          if (value!.length < 2) {
                            return "لا يمكن أن يكون الاسم أقل من حرفين";
                          }
                          return null;
                        },
                        onSave: ((newValue) {
                          box.put("name", newValue);
                        }),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("الفصيلة"),
                    ),
                    const BloodType(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text("العنوان"),
                    ),
                    AddressMainData(
                      formState: _formStateBloodType,
                    ),
                    const SizedBox(height: 30.0),
                    MyButton(
                        title: "حفظ",
                        onPressed: (() {
                          if (_formState.currentState!.validate() |
                              _formStateBloodType.currentState!.validate()) {
                            _formState.currentState!.save();
                            _formStateBloodType.currentState!.save();
                          }
                        }))
                  ],
                );
              }),
        ));
  }
}
