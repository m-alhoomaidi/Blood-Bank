import 'package:firebase_messaging/firebase_messaging.dart';

import '../../shared/encryption.dart';
import '../../models/donor.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? currentUser;

  Future<void> signUp({
    required Donor donor,
  }) async {
    emit(SignupLoading());
    try {
      await fireAuth
          .createUserWithEmailAndPassword(
              email: donor.email, password: donor.password)
          .then((userCredential) async {
        if (userCredential.user != null) {
          donor.id = userCredential.user!.uid;
          currentUser = userCredential.user;
          await FirebaseMessaging.instance.getToken().then((token) {
            donor.token = token!;
            fireStore
                .collection(DonorFields.collectionName)
                .add(donor.toMap())
                .then((value) => emit(SignupSuccess()));
          });
        }
      });
    } on FirebaseException catch (e) {
      String fireError = 'خطأ';
      switch (e.code) {
        case 'invalid-email':
          fireError = 'بريد غير صالح';
          break;
        case 'weak-password':
          fireError = 'كلمة المرور ضعيفة';
          break;
        case 'email-already-in-use':
          fireError = 'الحساب مسجل بالفعل';
          break;
        case 'unknown':
          fireError = 'تأكد من اتصال الإنترنت';
          break;
        default:
          fireError = 'خطأ غير معروف';
          break;
      }
      emit(SignupFailure(error: fireError));
    } catch (e) {
      emit(SignupFailure(error: e.toString()));
    }
  }
}
