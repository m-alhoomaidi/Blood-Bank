import 'dart:ffi';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/blood_center.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/pages/profile_center.dart';
import 'package:dartz/dartz.dart';

import '../../widgets/setting/profile_body.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Donor>> getDataToProfilePage();

  Future<Either<Failure, BloodCenter>> getProfileCenterData();

  Future<Either<Failure, Unit>> sendDataProfileSectionOne(
      {required ProfileLocalData profileLocalData});

  Future<Either<Failure, Unit>> sendBasicDataProfileSectionOne(
      {required ProfileLocalData profileLocalData});

  Future<Either<Failure, Unit>> sendBasicCenterDataProfile(
      {required ProfileCenterData profileCenterData});

  Future<Either<Failure, Unit>> sendProfileCenterData(
      {required ProfileCenterData profileCenterData});
}
