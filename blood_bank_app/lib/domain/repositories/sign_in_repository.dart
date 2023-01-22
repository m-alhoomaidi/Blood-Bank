import 'package:blood_bank_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<Either<Failure, UserCredential>> signIn({
    required String email,
    required String password,
  });
}
