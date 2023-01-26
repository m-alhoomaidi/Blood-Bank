// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchSuccess extends SearchState {
  List<Donor> donors;
  List<Donor> donorsInState;
  int selectedTabIndex;
  SearchSuccess({
    required this.donors,
    required this.donorsInState,
    required this.selectedTabIndex,
  });
}

class SearchLoading extends SearchState {}

class SearchFailure extends SearchState {
  final String error;
  SearchFailure({
    required this.error,
  });
}
