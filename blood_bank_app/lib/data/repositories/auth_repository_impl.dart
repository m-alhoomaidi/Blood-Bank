// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/exceptions.dart';
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/core/network/network_info.dart';
import 'package:blood_bank_app/domain/entities/blood_center.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
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
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({required String email}) async {
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

  @override
  Future<Either<Failure, Unit>> signUpDonor({
    required Donor donor,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return await _firebaseAuth
            .createUserWithEmailAndPassword(
          email: donor.email,
          password: donor.password,
        )
            .then((userCredential) async {
          if (userCredential.user != null) {
            try {
              return await _fireStore
                  .collection('donors')
                  .doc(userCredential.user!.uid)
                  .set(donor.toMap())
                  .then((_) async {
                return const Right(unit);
              });
            } on FirebaseException catch (fireError) {
              if (fireError.code == 'unknown') {
                return Left(FirebaseUnknownFailure());
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
            return left(WrongDataFailure());
          }
        });
      } on FirebaseException catch (fireError) {
        if (fireError.code == 'invalid-email') {
          return Left(InvalidEmailFailure());
        } else if (fireError.code == 'weak-password') {
          return Left(WeekPasswordFailure());
        } else if (fireError.code == 'email-already-in-use') {
          return Left(EmailAlreadyRegisteredFailure());
        } else if (fireError.code == 'unknown') {
          return Left(FirebaseUnknownFailure());
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
  }

  @override
  Future<Either<Failure, Unit>> signUpCenter({
    required BloodCenter center,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return await _firebaseAuth
            .createUserWithEmailAndPassword(
          email: center.email,
          password: center.password,
        )
            .then((userCredential) async {
          if (userCredential.user != null) {
            try {
              return await _fireStore
                  .collection('centers')
                  .doc(userCredential.user!.uid)
                  .set(center.toMap())
                  .then((_) async {
                return const Right(unit);
              });
            } on FirebaseException catch (fireError) {
              if (fireError.code == 'unknown') {
                return Left(FirebaseUnknownFailure());
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
            return left(WrongDataFailure());
          }
        });
      } on FirebaseException catch (fireError) {
        if (fireError.code == 'invalid-email') {
          return Left(InvalidEmailFailure());
        } else if (fireError.code == 'weak-password') {
          return Left(WeekPasswordFailure());
        } else if (fireError.code == 'email-already-in-use') {
          return Left(EmailAlreadyRegisteredFailure());
        } else if (fireError.code == 'unknown') {
          return Left(FirebaseUnknownFailure());
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
  }
}
