// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Donor extends Equatable {
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
  String lat;
  String lon;
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
    this.lat = '',
    this.lon = '',
    this.token = '',
    this.brithDate = '',
    this.image = '',
    this.isShown = "1",
    this.isShownPhone = "1",
    this.isGpsOn = "1",
    this.isExpanded = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DonorFields.id: id,
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
      DonorFields.lat: lat,
      DonorFields.lon: lon,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      id: map[DonorFields.id] ?? "",
      email: map[DonorFields.email] ?? "",
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
      lat: map[DonorFields.lat] ?? "",
      lon: map[DonorFields.lon] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Donor.fromJson(String source) =>
      Donor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        phone,
        state,
        district,
        neighborhood,
        image,
        brithDate,
        isShown,
        isShownPhone,
        isGpsOn,
        token,
        lat,
        lon,
      ];
}

class DonorFields {
  static const String collectionName = 'donors';
  static const String id = 'id';
  static const String email = 'email';
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
  static const String lat = 'lat';
  static const String lon = 'lon';
}
