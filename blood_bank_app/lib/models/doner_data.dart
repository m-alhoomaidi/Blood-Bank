import 'package:blood_bank_app/models/donor.dart';

class DonerCardData {
  DonerCardData({
    required this.name,
    required this.bloodType,
    required this.phone,
    required this.district,
    required this.isShownNumber,
    this.isExpanded = false,
  });

  String name;
  String bloodType;
  String district;
  String isShownNumber;
  String phone;
  bool isExpanded;

  static List<DonerCardData> generateItems({
    required int numberOfItems,
    required Donor donor,
  }) {
    return List<DonerCardData>.generate(numberOfItems, (int index) {
      return DonerCardData(
        name: donor.name,
        bloodType: donor.bloodType,
        phone: donor.phone,
        district: donor.district,
        isShownNumber: donor.isShownPhone,
      );
    });
  }
}
