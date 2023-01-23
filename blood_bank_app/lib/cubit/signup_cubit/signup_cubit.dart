// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import 'package:blood_bank_app/core/error/failures.dart';
import 'package:blood_bank_app/domain/usecases/sign_up_usecase.dart';

import '../../domain/entities/donor.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit({
    required this.signUpUseCase,
  }) : super(SignupInitial());
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? currentUser;
  final SignUpUseCase signUpUseCase;

  Future<void> signUp({
    required Donor donor,
  }) async {
    emit(SignupLoading());
    try {
      await signUpUseCase(donor: donor).then((value) {
        value.fold(
            (failure) =>
                emit(SignUpFailure(error: _getFailureMessage(failure))),
            (userCredential) => emit(SignUpSuccess()));
      });
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }

  String _getFailureMessage(Failure failur) {
    switch (failur.runtimeType) {
      case OffLineFailure:
        return "لا يوجد إنترنت";
      case WrongDataFailure:
        return "تأكد من صحة البيانات المدخلة";
      case InvalidEmailFailure:
        return "البريد الإلكتروني غير صالح";
      case EmailAlreadyRegisteredFailure:
        return "البريد مستخدم من قبل";
      case UnknownFailure:
        return "خطأ غير معروف";
      default:
        return "خطأ غير معروف";
    }
  }
}
