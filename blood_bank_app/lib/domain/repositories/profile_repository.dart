import 'dart:ffi';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:dartz/dartz.dart';

import '../../widgets/setting/profile_body.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Donor>> getDataToProfilePage();

  Future<Either<Failure, Unit>> sendDataProfileSectionOne(
      {required ProfileLocalData profileLocalData});
}