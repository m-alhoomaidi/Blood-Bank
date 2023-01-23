// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({
    required this.authRepository,
  });
  Future<Either<Failure, Unit>> call({
    required Donor donor,
  }) async {
    return await authRepository.signUpDonor(
      donor: donor,
    );
  }
}
