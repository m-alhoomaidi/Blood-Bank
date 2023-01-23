// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/profile_repository.dart';

import '../../core/network/network_info.dart';

class ProfileReopsitoryImpl implements ProfileRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final NetworkInfo networkInfo;
  Donor? donors;
  ProfileReopsitoryImpl({
    required this.networkInfo,
    this.donors,
  });
  @override
  Future<Either<Failure, Donor>> getDataToProfilePage() {
    // TODO: implement getDataToProfilePage
    throw UnimplementedError();
  }
}
