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

  // // For Maps
  // var location = loc.Location();
  // final Completer<GoogleMapController> _mapcontroller = Completer();
  // bool servicestatus = false;
  // bool haspermission = false;
  // bool hasCurrentLocation = false;
  // String long = "", lat = "";
  // DonorPoint me = DonorPoint(
  //   lat: 13.9585005,
  //   lon: 44.1709885,
  //   name: "أنا",
  //   bloodType: "",
  //   phone: "",
  //   token: "",
  // );
  // late LocationPermission permission;
  // late Position position;

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

            //   });
            // });

            // searchDonorsUseCase(
            //   state: selectedState,
            //   district: selectedDistrict,
            // ).then((donorsOrFailure) {
            //   donorsOrFailure.fold(
            //       (failure) =>
            //           emit(SearchFailure(error: getFailureMessage(failure))),
            //       (fetchedDonors) async {

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

  // Future<void> searchCenters() async {
  //   emit(SearchLoading());
  //   if (selectedState == '' ||
  //       selectedDistrict == '' ||
  //       selectedBloodType == null) {
  //     emit(SearchFailure(error: 'يجب تحديد المحافظة والمديرية وفصيلة الدم'));
  //   } else {
  //     try {
  //       fireStore
  //           .collection(BloodCenterFields.collectionName)
  //           .where(BloodCenterFields.state, isEqualTo: selectedState)
  //           .where(BloodCenterFields.district, isEqualTo: selectedDistrict)
  //           .get()
  //           .then((fetchedCenters) async {
  //         centers = fetchedCenters.docs
  //             .map((e) => BloodCenter.fromMap(e.data()))
  //             .toList();
  //         emit(
  //           SearchSuccess(
  //             donors: donors,
  //             centers: centers,
  //             stateDonors: stateDonors,
  //             selectedTabIndex: selectedTabBloodType,
  //           ),
  //         );
  //       });
  //     } on FirebaseException catch (e) {
  //       emit(SearchFailure(error: e.code));
  //     } catch (e) {
  //       emit(SearchFailure(error: e.toString()));
  //     }
  //   }
  // }

  // Future<void> searchDonors() async {
  //   emit(SearchLoading());
  //   if (selectedState == '' ||
  //       selectedDistrict == '' ||
  //       selectedBloodType == null) {
  //     emit(SearchFailure(error: 'يجب تحديد المحافظة والمديرية وفصيلة الدم'));
  //   } else {
  //     try {
  //       getDonorsInState();
  //       fireStore
  //           .collection(DonorFields.collectionName)
  //           .where(DonorFields.state, isEqualTo: selectedState)
  //           .where(DonorFields.district, isEqualTo: selectedDistrict)
  //           .get()
  //           .then((value) async {
  //         donors = value.docs.map((e) => Donor.fromMap(e.data())).toList();
  //         emit(
  //           SearchSuccess(
  //             donors: donors,
  //             donorsInState: donorsInState,
  //             selectedTabIndex: selectedTabBloodType,
  //           ),
  //         );
  //       });
  //     } on FirebaseException catch (e) {
  //       emit(SearchFailure(error: e.code));
  //     } catch (e) {
  //       emit(SearchFailure(error: e.toString()));
  //     }
  //   }
  // }

  // Future<void> getDonorsInState() async {
  //   emit(SearchLoading());
  //   if (selectedState == '' || selectedBloodType == null) {
  //     print('يجب تحديد المحافظة والمديرية وفصيلة الدم');
  //   } else {
  //     try {
  //       fireStore
  //           .collection(DonorFields.collectionName)
  //           .where(DonorFields.state, isEqualTo: selectedState)
  //           .get()
  //           .then((value) async {
  //         if (value.docs.isNotEmpty) {
  //           donorsInState = value.docs
  //               .map((donorDoc) => Donor.fromMap(donorDoc.data()))
  //               .toList();
  //         }
  //         emit(
  //           SearchSuccess(
  //             donors: donors,
  //             donorsInState: donorsInState,
  //             selectedTabIndex: selectedTabBloodType,
  //           ),
  //         );
  //       });
  //     } on FirebaseException catch (e) {
  //       print(e.code);
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   }
  // }
