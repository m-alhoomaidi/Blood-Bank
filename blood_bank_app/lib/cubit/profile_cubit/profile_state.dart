part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetData extends ProfileState {
  Donor donors;
  ProfileGetData({
    required this.donors,
  });
}

class ProfileSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure({required this.error});
}
