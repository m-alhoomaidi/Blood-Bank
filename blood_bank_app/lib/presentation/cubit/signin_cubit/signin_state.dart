part of 'signin_cubit.dart';

@immutable
abstract class SignInState {}

class SigninInitial extends SignInState {}

class SigninLoading extends SignInState {}

class SigninSuccess extends SignInState {}

class SigninSuccessResetPass extends SignInState {}

class SigninFailure extends SignInState {
  final String error;
  SigninFailure({required this.error});
}
