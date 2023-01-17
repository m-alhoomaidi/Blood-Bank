// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Donor {
  String id;
  String email;
  String password;
  String name;
  String phone;
  String bloodType;
  String state;
  String district;
  String neighborhood;
  String image;
  String brithDate;
  String isShown;
  String isShownPhone;
  String isGpsOn;
  String token;
  bool isExpanded;

  Donor({
    this.id = '',
    required this.email,
    this.password = '',
    required this.name,
    required this.phone,
    required this.bloodType,
    required this.state,
    required this.district,
    required this.neighborhood,
    this.token = '',
    this.brithDate = '',
    this.image = '',
    this.isShown = "1",
    this.isShownPhone = "1",
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
  //       "is_shown": donor.isShown,
  //       "is_shown_phone": donor.isShownNumber,
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
  //       isShownNumber: donor["is_shown_phone"],
  //       isGpsOn: donor["is_gps_on"],
  //     );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DonorFields.id: id,
      DonorFields.password: password,
      DonorFields.email: email,
      DonorFields.name: name,
      DonorFields.phone: phone,
      DonorFields.bloodType: bloodType,
      DonorFields.state: state,
      DonorFields.district: district,
      DonorFields.neighborhood: neighborhood,
      DonorFields.image: image,
      DonorFields.brithDate: brithDate,
      DonorFields.isShown: isShown,
      DonorFields.isShownPhone: isShownPhone,
      DonorFields.isGpsOn: isGpsOn,
      DonorFields.token: token,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      id: map[DonorFields.id] ?? "",
      email: map[DonorFields.email] ?? "",
      password: map[DonorFields.password] ?? "",
      name: map[DonorFields.name] ?? "",
      phone: map[DonorFields.phone] ?? "",
      bloodType: map[DonorFields.bloodType] ?? "",
      state: map[DonorFields.state] ?? "",
      district: map[DonorFields.district] ?? "",
      neighborhood: map[DonorFields.neighborhood] ?? "",
      image: map[DonorFields.image] ?? "",
      brithDate: map[DonorFields.brithDate] ?? "",
      isShown: map[DonorFields.isShown] ?? "",
      isShownPhone: map[DonorFields.isShownPhone] ?? "",
      isGpsOn: map[DonorFields.isGpsOn] ?? "",
      token: map[DonorFields.token] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Donor.fromJson(String source) =>
      Donor.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DonorFields {
  static const String collectionName = 'donors';
  static const String id = 'id';
  static const String email = 'email';
  static const String password = 'password';
  static const String name = 'name';
  static const String phone = 'phone';
  static const String bloodType = 'blood_type';
  static const String state = 'state';
  static const String district = 'district';
  static const String neighborhood = 'neighborhood';
  static const String image = 'image';
  static const String brithDate = 'brith_date';
  static const String isShown = 'is_shown';
  static const String isShownPhone = 'is_shown_phone';
  static const String isGpsOn = 'is_gps_on';
  static const String token = 'token';
}
