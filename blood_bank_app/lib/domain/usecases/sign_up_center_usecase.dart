// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/blood_center.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpCenterUseCase {
  final AuthRepository authRepository;
  SignUpCenterUseCase({
    required this.authRepository,
  });
  Future<Either<Failure, Unit>> call({
    required BloodCenter center,
  }) async {
    return await authRepository.signUpCenter(
      center: center,
    );
  }
}
