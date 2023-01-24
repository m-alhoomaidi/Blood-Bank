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
  String aPlus;
  String aMinus;
  String bPlus;
  String bMinus;
  String abPlus;
  String abMinus;
  String oPlus;
  String oMinus;
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
      name: map[BloodCenterField.name] as String,
      email: map[BloodCenterField.email] as String,
      password: map[BloodCenterField.password] as String,
      phone: map[BloodCenterField.phone] as String,
      state: map[BloodCenterField.state] as String,
      district: map[BloodCenterField.district] as String,
      neighborhood: map[BloodCenterField.neighborhood] as String,
      image: map[BloodCenterField.image] as String,
      lastUpdate: map[BloodCenterField.lastUpdate] as String,
      lat: map[BloodCenterField.lat] as String,
      lon: map[BloodCenterField.lon] as String,
      token: map[BloodCenterField.token] as String,
      aPlus: map[BloodCenterField.aPlus] as String,
      aMinus: map[BloodCenterField.aMinus] as String,
      bPlus: map[BloodCenterField.bPlus] as String,
      bMinus: map[BloodCenterField.bMinus] as String,
      abPlus: map[BloodCenterField.abPlus] as String,
      abMinus: map[BloodCenterField.abMinus] as String,
      oPlus: map[BloodCenterField.oPlus] as String,
      oMinus: map[BloodCenterField.oMinus] as String,
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
