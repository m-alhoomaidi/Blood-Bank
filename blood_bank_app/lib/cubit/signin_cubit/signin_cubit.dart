import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
part 'signin_state.dart';

class SingInCubit extends Cubit<SignInState> {
  SingInCubit() : super(SigninInitial());

  User? currentUser;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    // try {
    //   await fireAuth
    //       .createUserWithEmailAndPassword(email: email, password: password)
    //       .then((userCredential) {
    //     if (userCredential.user != null) {
    //       emit(SinginSuccess());
    //       currentUser = userCredential.user;
    //     }
    //   });
    // } catch (e) {
    //   emit(SinginFailure(error: e.toString()));
    // }
    try {
      await FirebaseAuth.instance
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
}
