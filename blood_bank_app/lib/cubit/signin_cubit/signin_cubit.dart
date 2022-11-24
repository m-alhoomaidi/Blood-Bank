import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'signin_state.dart';

class SingInCubit extends Cubit<SignInState> {
  SingInCubit() : super(SigninInitial());

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        if (userCredential.user != null) {
          emit(SigninSuccess());
          currentUser = userCredential.user;
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninFailure(error: "تاكد من صحة البيانات المدخلة"));
      } else if (e.code == 'wrong-password') {
        emit(SigninFailure(error: "كلمة المرور خاطئة"));
      }
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      emit(SigninLoading());
      await auth.sendPasswordResetEmail(email: email).then((value) {
        emit(SigninSuccessResetPass());
      });
    } catch (e) {
      emit(SigninFailure(error: "تحقق من صحة بريدك الالكتروني"));
    }
  }
}
