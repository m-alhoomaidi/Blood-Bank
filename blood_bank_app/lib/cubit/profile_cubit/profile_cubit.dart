// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:blood_bank_app/domain/usecases/profile_use_case.dart';
import 'package:blood_bank_app/widgets/setting/profile_body.dart';

import '../../domain/entities/donor.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileCubit({
    required this.profileUseCase,
  }) : super(ProfileInitial());
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Donor? donors;

  Future<void> getDataToProfilePage() async {
    try {
      emit(ProfileLoading());
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore
            .collection('donors')
            .doc("9U74upZiSOJugT9wrDnu")
            .get()
            .then((value) async {
          donors = Donor.fromMap(value.data()!);
          emit(ProfileGetData(donors: donors!));
        });
      } else {
        emit(ProfileFailure(error: "tttt"));
      }
    } catch (e) {
      emit(ProfileFailure(error: "pppppppppppp"));
    }
  }

  Future<void> sendDataProfileSectionOne(
      ProfileLocalData profileLocalData) async {
    try {
      emit(ProfileLoading());
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore
            .collection('donors')
            .doc("9U74upZiSOJugT9wrDnu")
            .update({
          DonorFields.isGpsOn: profileLocalData.isGpsOn,
          DonorFields.isShown: profileLocalData.isShown,
          DonorFields.isShownPhone: profileLocalData.isShownPhone,
          DonorFields.brithDate: profileLocalData.date,
        }).then((value) async {
          emit(ProfileSuccess());
          getDataToProfilePage();
        });
      } else {
        print("1111111111111111111111111");
        emit(ProfileFailure(
            error: "لم يتم حفظ البيانات تاكد من الاتصال بالانترنت"));
      }
    } catch (e) {
      print("222222222222222222222222222222222");
      emit(ProfileFailure(
          error: "لم يتم حفظ البيانات تاكد من الاتصال بالانترنت"));
    }
  }

  Future<void> sendBasicDataProfileSectionOne(
      ProfileLocalData profileLocalData) async {
    try {
      emit(ProfileLoading());
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore
            .collection('donors')
            .doc("9U74upZiSOJugT9wrDnu")
            .update({
          DonorFields.name: profileLocalData.name,
          DonorFields.bloodType: profileLocalData.bloodType,
          DonorFields.state: profileLocalData.state,
          DonorFields.district: profileLocalData.district,
          DonorFields.neighborhood: profileLocalData.neighborhood,
        }).then((value) async {
          emit(ProfileSuccess());
          getDataToProfilePage();
        });
      } else {
        print("1111111111111111111111111");
        emit(ProfileFailure(
            error: "لم يتم حفظ البيانات تاكد من الاتصال بالانترنت"));
      }
    } catch (e) {
      print("222222222222222222222222222222222");
      emit(ProfileFailure(
          error: "لم يتم حفظ البيانات تاكد من الاتصال بالانترنت"));
    }
  }
}
