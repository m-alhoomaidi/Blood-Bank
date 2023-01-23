// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase {
  final AuthRepository resetPasswordRepository;
  ResetPasswordUseCase({
    required this.resetPasswordRepository,
  });

  Future<Either<Failure, void>> call({required String email}) async {
    return await resetPasswordRepository.resetPassword(email: email);
  }
}
