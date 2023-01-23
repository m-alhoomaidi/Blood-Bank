import 'package:bloc/bloc.dart';
import 'package:blood_bank_app/widgets/setting/profile_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/donor.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Donor? donors;

  Future<void> getDataToProfilePage() async {
    try {
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
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore.collection('donors').doc(currentUser.uid).update({
          DonorFields.isGpsOn: profileLocalData.is_gps_on,
          DonorFields.isShown: profileLocalData.isShown,
          DonorFields.isShownPhone: profileLocalData.is_shown_phone,
          DonorFields.brithDate: profileLocalData.date,
        }).then((value) async {
          emit(ProfileSuccess());
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
