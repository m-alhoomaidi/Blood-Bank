import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  User? currentUser;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      await fireAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        if (userCredential.user != null) {
          emit(SignupSuccess());
          currentUser = userCredential.user;
        }
      });
    } catch (e) {
      emit(SignupFailure(error: e.toString()));
    }
  }
}
