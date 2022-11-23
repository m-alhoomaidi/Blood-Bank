// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String error;
  SignupFailure({required this.error});
}
