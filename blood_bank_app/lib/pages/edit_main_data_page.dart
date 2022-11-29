import 'package:blood_bank_app/widgets/edit_main_data/address.dart';
import 'package:blood_bank_app/widgets/forms/my_button.dart';
import 'package:blood_bank_app/widgets/forms/my_text_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/edit_main_data/blood_type.dart';

class EditMainDataPage extends StatefulWidget {
  const EditMainDataPage({super.key});
  static const String routeName = "edit_main_data";

  @override
  State<EditMainDataPage> createState() => _EditMainDataPageState();
}

class _EditMainDataPageState extends State<EditMainDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل البيانات الاساسية"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("الاسم"),
            ),
            MyTextFormField(
              validator: (value) {
                if (value!.length < 2) {
                  return "لا يمكن أن يكون الاسم أقل من حرفين";
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("الفصيلة"),
            ),
            const BloodType(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("العنوان"),
            ),
            const AddressMainData(),
            const SizedBox(height: 30.0),
            MyButton(title: "حفظ", onPressed: (() {}))
          ],
        ),
      ),
    );
  }
}
