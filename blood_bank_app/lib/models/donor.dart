// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Donor {
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
  String gender;
  String isShown;
  String isShownNumber;
  String isGpsOn;

  Donor({
    required this.email,
    required this.password,
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'bloodType': bloodType,
      'state': state,
      'district': district,
      'neighborhood': neighborhood,
      'image': image,
      'brithDate': brithDate,
      'gender': gender,
      'isShown': isShown,
      'isShownNumber': isShownNumber,
      'isGpsOn': isGpsOn,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      bloodType: map['bloodType'] as String,
      state: map['state'] as String,
      district: map['district'] as String,
      neighborhood: map['neighborhood'] as String,
      image: map['image'] as String,
      brithDate: map['brithDate'] as String,
      gender: map['gender'] as String,
      isShown: map['isShown'] as String,
      isShownNumber: map['isShownNumber'] as String,
      isGpsOn: map['isGpsOn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Donor.fromJson(String source) =>
      Donor.fromMap(json.decode(source) as Map<String, dynamic>);
}
