import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/donor.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? currentUser;

  Future<void> signUp({
    required Donor donor,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      await fireAuth
          .createUserWithEmailAndPassword(
              email: donor.email, password: password)
          .then((userCredential) async {
        if (userCredential.user != null) {
          currentUser = userCredential.user;
          fireStore
              .collection('donor')
              .add(Donor.toMap(donor))
              .then((value) => emit(SignupSuccess()));
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
