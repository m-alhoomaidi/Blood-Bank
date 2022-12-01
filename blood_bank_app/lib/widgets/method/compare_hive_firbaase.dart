import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../models/donor.dart';
import '../../pages/setting_page.dart';

class CompareHiveAndFireStore {
  void compareHiveAndFirestore() async {
    Donor donor;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore
            .collection('donors')
            .doc("H5PPBI8VBBNikBYvmifb")
            .get()
            .then((value) async {
          donor = Donor.fromMap(value.data()!);

          if (Hive.box(dataBoxName) != null) {
            if (kDebugMode) {
              print("22222222222222222222222222222");
            }
            if (Hive.box(dataBoxName).get("name") == donor.name &&
                Hive.box(dataBoxName).get("blood_type") == donor.bloodType &&
                donor.isShown == Hive.box(dataBoxName).get("is_shown") &&
                donor.isGpsOn == Hive.box(dataBoxName).get("is_gps_on") &&
                donor.isShownPhone ==
                    Hive.box(dataBoxName).get("is_shown_phone") &&
                Hive.box(dataBoxName).get("date") == donor.brithDate &&
                donor.district == Hive.box(dataBoxName).get("district") &&
                donor.state == Hive.box(dataBoxName).get("satae") &&
                donor.neighborhood ==
                    Hive.box(dataBoxName).get("neighborhood")) {
            } else {
              await _fireStore
                  .collection('donors')
                  .doc("H5PPBI8VBBNikBYvmifb")
                  .update({
                "state": Hive.box(dataBoxName).get("satae"),
                "neighborhood": Hive.box(dataBoxName).get("neighborhood"),
                "district": Hive.box(dataBoxName).get("district"),
                "name": Hive.box(dataBoxName).get("name"),
                "blood_type": Hive.box(dataBoxName).get("blood_type"),
                "is_shown": Hive.box(dataBoxName).get("is_shown"),
                "is_shown_phone": Hive.box(dataBoxName).get("is_shown_phone"),
                "is_gps_on": Hive.box(dataBoxName).get("is_gps_on"),
                "brith_date": Hive.box(dataBoxName).get("date"),
              });
            }
          } else if (Hive.box(dataBoxName).isNotEmpty) {
            print("33333333333333333333333");
            Hive.box(dataBoxName).put("name", donor.name);
            Hive.box(dataBoxName).put("blood_type", donor.bloodType);
            Hive.box(dataBoxName).put("is_shown", donor.isShown);

            Hive.box(dataBoxName).put("is_gps_on", donor.isGpsOn);

            Hive.box(dataBoxName).put("is_shown_phone", donor.isShownPhone);
            Hive.box(dataBoxName).put("date", donor.brithDate);

            Hive.box(dataBoxName).put("district", donor.district);
            Hive.box(dataBoxName).put("satae", donor.state);
            Hive.box(dataBoxName).put("neighborhood", donor.neighborhood);
          }
        });
      } else {}
    } catch (e) {}
  }
}
