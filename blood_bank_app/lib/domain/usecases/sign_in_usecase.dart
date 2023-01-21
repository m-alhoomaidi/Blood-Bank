// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
  final SignInRepository authRepository;
  SignInUseCase({
    required this.authRepository,
  });
  Future<UserCredential> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signIn(email: email, password: password);
  }
}
