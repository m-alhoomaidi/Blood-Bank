import 'package:bloc/bloc.dart';
import 'package:blood_bank_app/models/donor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  FirebaseAuth fireAuth = FirebaseAuth.instance;
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
          .then((userCredential) {
        if (userCredential.user != null) {
          emit(SignupSuccess());
          currentUser = userCredential.user;
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

  Future<void> addUserData({required Donor donor}) async {}
}
