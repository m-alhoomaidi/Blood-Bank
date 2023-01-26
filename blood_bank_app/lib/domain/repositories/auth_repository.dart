import '../../core/error/failures.dart';
import '../entities/blood_center.dart';
import '../entities/donor.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  Future<Either<Failure, Unit>> signUpDonor({
    required Donor donor,
  });

  Future<Either<Failure, Unit>> signUpCenter({
    required BloodCenter center,
  });
}
