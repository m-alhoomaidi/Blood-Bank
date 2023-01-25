import 'package:blood_bank_app/core/network/network_info.dart';
import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/cubit/search_cubit/search_cubit.dart';
import 'package:blood_bank_app/cubit/signin_cubit/signin_cubit.dart';
import 'package:blood_bank_app/cubit/signup_cubit/signup_cubit.dart';
import 'package:blood_bank_app/data/repositories/auth_repository_impl.dart';
import 'package:blood_bank_app/data/repositories/search_repository_impl.dart';
import 'package:blood_bank_app/domain/repositories/profile_repository.dart';
import 'package:blood_bank_app/domain/repositories/auth_repository.dart';
import 'package:blood_bank_app/domain/usecases/profile_use_case.dart';
import 'package:blood_bank_app/domain/usecases/reset_password_use_case.dart';
import 'package:blood_bank_app/domain/usecases/search_for_donors_usecase.dart';
import 'package:blood_bank_app/domain/usecases/sign_in_usecase.dart';
import 'package:blood_bank_app/domain/usecases/sign_up_center_usecase.dart';
import 'package:blood_bank_app/domain/usecases/sign_up_donor_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'data/repositories/profile_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initApp() async {
  // Search Repositories
  sl.registerLazySingleton(() => SearchRepositoryImpl(networkInfo: sl()));
  // Search UseCases
  sl.registerLazySingleton(
      () => SearchForDonorsUseCase(searchRepository: sl()));
  // Search Cubit
  sl.registerLazySingleton(() => SearchCubit(searchForDonorsUseCase: sl()));

  // Profile Repositories
  sl.registerFactory<ProfileRepository>(
      () => ProfileReopsitoryImpl(networkInfo: sl()));

  // Profile UseCases
  sl.registerFactory(() => ProfileUseCase(profileRepository: sl()));

  // Profile Cubits
  sl.registerFactory(() => ProfileCubit(profileUseCase: sl()));

  /// Core

  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoChecker(connectionChecker: sl()));

  /// External

  // Internet Info Checker
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 15)));
}

initSignIn() {
  if (!GetIt.I.isRegistered<SingInCubit>()) {
    // Repositories
    sl.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(networkInfo: sl()));

    // UseCases
    sl.registerFactory(() => SignInUseCase(authRepository: sl()));

    sl.registerFactory(
        () => ResetPasswordUseCase(resetPasswordRepository: sl()));
    // Cubits
    sl.registerFactory(
        () => SingInCubit(signInUseCase: sl(), resetPasswordUseCase: sl()));
  }
}

initSignUp() {
  if (!GetIt.I.isRegistered<SignUpCubit>()) {
    // Repositories
    sl.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(networkInfo: sl()));

    // UseCases
    sl.registerFactory(() => SignUpDonorUseCase(authRepository: sl()));
    sl.registerFactory(() => SignUpCenterUseCase(authRepository: sl()));

    // Cubits
    sl.registerFactory(
        () => SignUpCubit(signUpDonorUseCase: sl(), signUpCenterUseCase: sl()));
  }
}
