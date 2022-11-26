import 'package:bloc/bloc.dart';
import 'package:blood_bank_app/models/donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<Donor> donors = [];

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> searchDonors({
    required String state,
    required String district,
    required String bloodType,
  }) async {
    emit(SearchLoading());
    try {
      fireStore
          .collection(DonorFields.collectionName)
          .where(DonorFields.bloodType, isEqualTo: bloodType)
          .get()
          .then((value) async {
        donors = value.docs.map((e) => Donor.fromMap(e.data())).toList();
        emit(SearchSuccess(donors: donors));
      });
    } on FirebaseException catch (e) {
      emit(SearchFailure(error: e.code));
    } catch (e) {
      emit(SearchFailure(error: e.toString()));
    }
  }
}
