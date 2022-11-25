// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Donor {
  String email;
  String name;
  String phone;
  String bloodType;
  String state;
  String district;
  String neighborhood;
  String image;
  String brithDate;
  String gender;
  String isShown;
  String isShownNumber;
  String isGpsOn;
  bool isExpanded;

  Donor({
    required this.email,
    required this.name,
    required this.phone,
    required this.bloodType,
    required this.state,
    required this.district,
    required this.neighborhood,
    this.brithDate = '',
    this.image = '',
    this.gender = "male",
    this.isShown = "1",
    this.isShownNumber = "1",
    this.isGpsOn = "1",
    this.isExpanded = false,
  });

  // static Map<String, String> toMap(Donor donor) => {
  //       "name": donor.name,
  //       "number": donor.phone,
  //       "blood_type": donor.bloodType,
  //       "state": donor.state,
  //       "district": donor.district,
  //       "neighborhood": donor.neighborhood,
  //       "image": donor.image,
  //       "brithdate": donor.brithDate,
  //       "gender": donor.brithDate,
  //       "is_shown": donor.isShown,
  //       "is_shown_number": donor.isShownNumber,
  //       "is_gps_on": donor.isGpsOn
  //     };

  // static Donor fromJson(donor) => Donor(
  //       email: donor["email"],
  //       password: donor["pass"],
  //       name: donor["name"],
  //       phone: donor["number"],
  //       bloodType: donor["bloodType"],
  //       state: donor["state"],
  //       district: donor["district"],
  //       neighborhood: donor["neighborhood"],
  //       image: donor["image"],
  //       brithDate: donor["brithDate"],
  //       isShown: donor["is_shown"],
  //       isShownNumber: donor["is_shown_number"],
  //       isGpsOn: donor["is_gps_on"],
  //     );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phone': phone,
      'blood_type': bloodType,
      'state': state,
      'district': district,
      'neighborhood': neighborhood,
      'image': image,
      'brith_date': brithDate,
      'gender': gender,
      'is_shown': isShown,
      'is_shown_number': isShownNumber,
      'is_gps_on': isGpsOn,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      bloodType: map['blood_type'] as String,
      state: map['state'] as String,
      district: map['district'] as String,
      neighborhood: map['neighborhood'] as String,
      image: map['image'] as String,
      brithDate: map['brith_date'] as String,
      gender: map['gender'] as String,
      isShown: map['is_shown'] as String,
      isShownNumber: map['is_shown_number'] as String,
      isGpsOn: map['is_gps_on'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Donor.fromJson(String source) =>
      Donor.fromMap(json.decode(source) as Map<String, dynamic>);
}
