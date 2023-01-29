// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/blood_center.dart';
import '../../../domain/usecases/search_centers_usecase.dart';
import '../../../domain/entities/donor.dart';
import '../../../domain/usecases/search_state_donors_usecase.dart';
import '../../../core/error/failures.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchStateDonorsUseCase searchStateDonorsUseCase;
  // final SearchDonorsUseCase searchDonorsUseCase;
  final SearchCentersUseCase searchCentersUseCase;
  SearchCubit({
    required this.searchStateDonorsUseCase,
    // required this.searchDonorsUseCase,
    required this.searchCentersUseCase,
  }) : super(SearchInitial());

  List<Donor> donors = [], stateDonors = [];
  List<BloodCenter> centers = [];
  String selectedState = '', selectedDistrict = '';
  String? selectedBloodType;
  int selectedTabBloodType = 0;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> searchDonorsAndCenters() async {
    emit(SearchLoading());
    if (selectedState == '' ||
        selectedDistrict == '' ||
        selectedBloodType == null) {
      emit(SearchFailure(error: 'يجب تحديد المحافظة والمديرية وفصيلة الدم'));
    } else {
      try {
        searchStateDonorsUseCase(
          state: selectedState,
        ).then((stateDonorsOrFailure) {
          stateDonorsOrFailure.fold(
              (failure) =>
                  emit(SearchFailure(error: getFailureMessage(failure))),
              (fetchedStateDonors) async {
            stateDonors = fetchedStateDonors;
            donors = fetchedStateDonors
                .where((donor) => donor.district == selectedDistrict)
                .toList();
            await searchCentersUseCase(
              state: selectedState,
              district: selectedDistrict,
            ).then((centersOrFailure) {
              centersOrFailure.fold(
                (failure) =>
                    emit(SearchFailure(error: getFailureMessage(failure))),
                (fetchedCenters) {
                  centers = fetchedCenters;
                  emit(
                    SearchSuccess(
                      donors: donors,
                      centers: fetchedCenters,
                      stateDonors: stateDonors,
                      selectedTabIndex: selectedTabBloodType,
                    ),
                  );
                },
              );
            });
          });
        });
      } on FirebaseException catch (e) {
        emit(SearchFailure(error: e.code));
      } catch (e) {
        emit(SearchFailure(error: e.toString()));
      }
    }
  }

  void setSelectedTabBloodType({required int tabIndex}) async {
    emit(
      SearchSuccess(
        donors: donors,
        centers: centers,
        stateDonors: stateDonors,
        selectedTabIndex: tabIndex,
      ),
    );
  }
}
