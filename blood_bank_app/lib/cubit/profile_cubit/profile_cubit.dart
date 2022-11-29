import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blood_bank_app/models/donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Donor? donors;

  Future<void> getDataProfile() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _fireStore
            .collection('donors')
            .doc("H5PPBI8VBBNikBYvmifb")
            .get()
            .then((value) async {
          print(value.data());
          print("object+++++++++++++++++++++");
          print(currentUser.uid);
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
}
