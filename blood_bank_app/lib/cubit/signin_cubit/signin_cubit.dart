import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'signin_state.dart';

class SingInCubit extends Cubit<SignInState> {
  SingInCubit() : super(SigninInitial());

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
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

  Future<String> isPhoneRegisterd(
      {required String phone,
      required String type,
      String password = ""}) async {
    String result = "Error";
    try {
      emit(SigninLoading());
      await _fireStore
          .collection("donors")
          .where("phone", isEqualTo: phone)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          result = await value.docs[0].get("email");
          if (type == "forget") {
            resetPassword(email: result)
                .then((value) {})
                .onError((error, stackTrace) {
              emit(SigninFailure(error: "راجع البيانات المدخلة "));
            });
          } else if (type == "signin") {
            signIn(email: result, password: password);
          }
        } else {
          emit(SigninFailure(error: "رقم الهاتق الذي ادخلته غير صحيح"));
        }
      }).onError((error, stackTrace) {});
    } on FirebaseException catch (e) {
      emit(SigninFailure(error: "راجع البيانات المدخلة "));
    } catch (e) {
      emit(SigninFailure(error: "راجع البيانات المدخلة "));
    }
    return result;
  }
}
