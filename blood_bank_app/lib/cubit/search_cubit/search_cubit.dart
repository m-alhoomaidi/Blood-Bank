import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<Donor> donors = [], donorsInState = [];
  String selectedState = '', selectedDistrict = '';
  String? selectedBloodType;
  int selectedTabBloodType = 0;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> searchDonors() async {
    emit(SearchLoading());
    if (selectedState == '' ||
        selectedDistrict == '' ||
        selectedBloodType == null) {
      emit(SearchFailure(error: 'يجب تحديد المحافظة والمديرية وفصيلة الدم'));
    } else {
      try {
        getDonorsInState();
        fireStore
            .collection(DonorFields.collectionName)
            .where(DonorFields.state, isEqualTo: selectedState)
            .where(DonorFields.district, isEqualTo: selectedDistrict)
            .get()
            .then((value) async {
          donors = value.docs.map((e) => Donor.fromMap(e.data())).toList();

          emit(
            SearchSuccess(
              donors: donors,
              donorsInState: donorsInState,
              selectedTabIndex: selectedTabBloodType,
            ),
          );
        });
      } on FirebaseException catch (e) {
        emit(SearchFailure(error: e.code));
      } catch (e) {
        emit(SearchFailure(error: e.toString()));
      }
    }
  }

  Future<void> getDonorsInState() async {
    emit(SearchLoading());
    if (selectedState == '' || selectedBloodType == null) {
      print('يجب تحديد المحافظة والمديرية وفصيلة الدم');
    } else {
      try {
        fireStore
            .collection(DonorFields.collectionName)
            .where(DonorFields.state, isEqualTo: selectedState)
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            donorsInState = value.docs
                .map((donorDoc) => Donor.fromMap(donorDoc.data()))
                .toList();
          }
          emit(
            SearchSuccess(
              donors: donors,
              donorsInState: donorsInState,
              selectedTabIndex: selectedTabBloodType,
            ),
          );
        });
      } on FirebaseException catch (e) {
        print(e.code);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void setSelectedTabBloodType({required int tabIndex}) async {
    emit(
      SearchSuccess(
        donors: donors,
        donorsInState: donorsInState,
        selectedTabIndex: tabIndex,
      ),
    );
  }
}
