// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/core/network/network_info.dart';
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final NetworkInfo networkInfo;
  SignInRepositoryImpl({
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        return await _firebaseAuth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((userCredential) async {
          if (userCredential.user != null) {
            return Right(userCredential);
          } else {
            return Left(UnknownFailure());
          }
        });
      } on FirebaseException catch (fireError) {
        if (fireError.code == 'user-not-found') {
          return Left(WrongDataFailure());
        } else if (fireError.code == 'wrong-password') {
          return Left(WrongDataFailure());
        } else if (fireError.code == 'too-many-request') {
          return Left(ServerFailure());
        } else {
          return Left(UnknownFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
    // return Left(OffLineFailure());
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        return await _firebaseAuth
            .sendPasswordResetEmail(
          email: email,
        )
            .then((userCredential) async {
          return const Right(unit);
        });
      } on FirebaseException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
