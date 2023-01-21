import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });
}
