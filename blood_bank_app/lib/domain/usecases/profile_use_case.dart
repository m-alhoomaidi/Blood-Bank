// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/profile_repository.dart';
import 'package:blood_bank_app/pages/profile_center.dart';
import 'package:blood_bank_app/widgets/setting/profile_body.dart';
import 'package:dartz/dartz.dart';

class ProfileUseCase {
  final ProfileRepository profileRepository;
  ProfileUseCase({
    required this.profileRepository,
  });

  Future<Either<Failure, Donor>> call() {
    return profileRepository.getDataToProfilePage();
  }

  Future<Either<Failure, Unit>> callsendDataSectionOne(
      {required ProfileLocalData profileLocalData}) {
    return profileRepository.sendDataProfileSectionOne(
        profileLocalData: profileLocalData);
  }

  Future<Either<Failure, Unit>> callsendBasicDataProfileSectionOne(
      {required ProfileLocalData profileLocalData}) {
    return profileRepository.sendBasicDataProfileSectionOne(
        profileLocalData: profileLocalData);
  }

  Future<Either<Failure, Unit>> callsendBasicCenterDataProfile(
      {required ProfileCenterData profileCenterData}) {
    return profileRepository.sendBasicCenterDataProfile(
        profileCenterData: profileCenterData);
  }
}
