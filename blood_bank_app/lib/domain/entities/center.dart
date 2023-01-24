import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BloodCenter {
  String name;
  String email;
  String password;
  String phone;
  String state;
  String district;
  String neighborhood;
  String image;
  String lastUpdate;
  String lat;
  String lon;
  String token;
  int aPlus;
  int aMinus;
  int bPlus;
  int bMinus;
  int abPlus;
  int abMinus;
  int oPlus;
  int oMinus;
  BloodCenter({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.state,
    required this.district,
    required this.neighborhood,
    required this.image,
    required this.lastUpdate,
    required this.lat,
    required this.lon,
    required this.token,
    required this.aPlus,
    required this.aMinus,
    required this.bPlus,
    required this.bMinus,
    required this.abPlus,
    required this.abMinus,
    required this.oPlus,
    required this.oMinus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      BloodCenterField.name: name,
      BloodCenterField.email: email,
      BloodCenterField.password: password,
      BloodCenterField.phone: phone,
      BloodCenterField.state: state,
      BloodCenterField.district: district,
      BloodCenterField.neighborhood: neighborhood,
      BloodCenterField.image: image,
      BloodCenterField.lastUpdate: lastUpdate,
      BloodCenterField.lat: lat,
      BloodCenterField.lon: lon,
      BloodCenterField.token: token,
      BloodCenterField.aPlus: aPlus,
      BloodCenterField.aMinus: aMinus,
      BloodCenterField.bPlus: bPlus,
      BloodCenterField.bMinus: bMinus,
      BloodCenterField.abPlus: abPlus,
      BloodCenterField.abMinus: abMinus,
      BloodCenterField.oPlus: oPlus,
      BloodCenterField.oMinus: oMinus,
    };
  }

  factory BloodCenter.fromMap(Map<String, dynamic> map) {
    return BloodCenter(
      name: map[BloodCenterField.name] ?? "",
      email: map[BloodCenterField.email] ?? "",
      password: map[BloodCenterField.password] ?? "",
      phone: map[BloodCenterField.phone] ?? "",
      state: map[BloodCenterField.state] ?? "",
      district: map[BloodCenterField.district] ?? "",
      neighborhood: map[BloodCenterField.neighborhood] ?? "",
      image: map[BloodCenterField.image] ?? "",
      lastUpdate: map[BloodCenterField.lastUpdate] ?? "",
      lat: map[BloodCenterField.lat] ?? "",
      lon: map[BloodCenterField.lon] ?? "",
      token: map[BloodCenterField.token] ?? "",
      aPlus: map[BloodCenterField.aPlus] ?? 0,
      aMinus: map[BloodCenterField.aMinus] ?? 0,
      bPlus: map[BloodCenterField.bPlus] ?? 0,
      bMinus: map[BloodCenterField.bMinus] ?? 0,
      abPlus: map[BloodCenterField.abPlus] ?? 0,
      abMinus: map[BloodCenterField.abMinus] ?? 0,
      oPlus: map[BloodCenterField.oPlus] ?? 0,
      oMinus: map[BloodCenterField.oMinus] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodCenter.fromJson(String source) =>
      BloodCenter.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BloodCenterField {
  static const String name = "name";
  static const String email = "email";
  static const String password = "password";
  static const String phone = "phone";
  static const String state = "state";
  static const String district = "district";
  static const String neighborhood = "neighborhood";
  static const String image = "image";
  static const String lastUpdate = "last_update";
  static const String lat = "lat";
  static const String lon = "lon";
  static const String token = "token";
  static const String aPlus = "A+";
  static const String aMinus = "A-";
  static const String bPlus = "B+";
  static const String bMinus = "B-";
  static const String abPlus = "AB+";
  static const String abMinus = "AB-";
  static const String oPlus = "O+";
  static const String oMinus = "O-";
}
