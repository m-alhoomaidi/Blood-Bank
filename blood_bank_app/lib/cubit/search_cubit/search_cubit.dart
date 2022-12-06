import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:blood_bank_app/models/donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<Donor> donors = [];
  String selectedState = '', selectedDistrict = '', selectedBloodType = '';
  int selectedTabBloodType = 0;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> searchDonors() async {
    emit(SearchLoading());
    if (selectedState == '' ||
        selectedDistrict == '' ||
        selectedBloodType == '') {
      emit(SearchFailure(error: 'يجب تحديد المحافظة والمديرية وفصيلة الدم'));
    } else {
      try {
        fireStore
            .collection(DonorFields.collectionName)
            .where(DonorFields.state, isEqualTo: selectedState)
            .where(DonorFields.district, isEqualTo: selectedDistrict)
            .get()
            .then((value) async {
          donors = value.docs.map((e) => Donor.fromMap(e.data())).toList();
          emit(SearchSuccess(
              donors: donors, selectedTabIndex: selectedTabBloodType));
        });
      } on FirebaseException catch (e) {
        emit(SearchFailure(error: e.code));
      } catch (e) {
        emit(SearchFailure(error: e.toString()));
      }
    }
  }

  void setSelectedTabBloodType({required int tabIndex}) async {
    emit(SearchSuccess(selectedTabIndex: tabIndex, donors: donors));
  }
}
