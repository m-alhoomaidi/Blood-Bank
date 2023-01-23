// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/profile_repository.dart';

import '../../core/network/network_info.dart';
import '../../widgets/setting/profile_body.dart';

class ProfileReopsitoryImpl implements ProfileRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth currentUser = FirebaseAuth.instance;

  final NetworkInfo networkInfo;
  Donor? donors;
  ProfileReopsitoryImpl({
    required this.networkInfo,
    this.donors,
  });
  @override
  Future<Either<Failure, Donor>> getDataToProfilePage() async {
    if (await networkInfo.isConnected) {
      try {
        if (currentUser != null) {
          return await _fireStore
              .collection('donors')
              .doc("9U74upZiSOJugT9wrDnu")
              .get()
              .then((value) async {
            donors = Donor.fromMap(value.data()!);
            return Right(donors!);
          });
        } else {
          return Left(DoesnotSaveData());
        }
      } catch (e) {
        return Left(DoesnotSaveData());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendDataProfileSectionOne(
      {required ProfileLocalData profileLocalData}) async {
    if (await networkInfo.isConnected) {
      try {
        if (currentUser != null) {
          return await _fireStore
              .collection('donors')
              .doc("9U74upZiSOJugT9wrDnu")
              .update({
            DonorFields.isGpsOn: profileLocalData.isGpsOn,
            DonorFields.isShown: profileLocalData.isShown,
            DonorFields.isShownPhone: profileLocalData.isShownPhone,
            DonorFields.brithDate: profileLocalData.date,
          }).then((value) async {
            // emit(ProfileSuccess());
            // getDataToProfilePage();
            return Right(unit);
          });
        } else {
          return Left(DoesnotSaveData());
          // emit(ProfileFailure(
          //     error: "لم يتم حفظ البيانات تاكد من الاتصال بالانترنت"));
        }
      } catch (e) {
        return Left(DoesnotSaveData());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
