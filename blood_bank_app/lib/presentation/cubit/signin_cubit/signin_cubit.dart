// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failures.dart';
import '../../../domain/usecases/reset_password_use_case.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.signInUseCase,
    required this.resetPasswordUseCase,
  }) : super(SignInInitial());

  final SignInUseCase signInUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SignInLoading());
    try {
      await signInUseCase(email: email, password: password)
          .then((userCredentialOrFailure) {
        userCredentialOrFailure.fold(
          (failure) => emit(SigninFailure(error: getFailureMessage(failure))),
          (userCredential) async {
            await updateToken(userCredential.user!.uid);
            emit(SignInSuccess());
          },
        );
      });
    } catch (e) {
      //  emit(SigninFailure(error:"تحقق من صحة بريدك الالكتروني"));
    }
  }

  Future<void> updateToken(String uid) async {
    String token = await getToken();
    FirebaseFirestore.instance.collection("donors").doc(uid).update({
      "token": token,
    });
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    emit(SignInLoading());
    try {
      await resetPasswordUseCase(email: email).then((unitOrFailuer) {
        unitOrFailuer.fold(
          (failure) => emit(SigninFailure(error: getFailureMessage(failure))),
          (_) => emit(SignInSuccessResetPass()),
        );
      });
    } catch (e) {
      emit(SigninFailure(error: "تحقق من صحة بريدك الالكتروني"));
    }
  }

  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }
}
