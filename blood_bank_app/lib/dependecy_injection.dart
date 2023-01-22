import 'package:blood_bank_app/core/network/network_info.dart';
import 'package:blood_bank_app/cubit/signin_cubit/signin_cubit.dart';
import 'package:blood_bank_app/data/repositories/sign_in_repository_impl.dart';
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';
import 'package:blood_bank_app/domain/usecases/reset_password_use_case.dart';
import 'package:blood_bank_app/domain/usecases/sign_in_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initApp() async {
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
    sl.registerFactory(
        () => SingInCubit(signInUseCase: sl(), resetPasswordUseCase: sl()));

    // UseCases
    sl.registerFactory(() => SignInUseCase(authRepository: sl()));

    sl.registerFactory(
        () => ResetPasswordUseCase(resetPasswordRepository: sl()));

    // Repositories
    sl.registerFactory<SignInRepository>(
        () => SignInRepositoryImpl(networkInfo: sl()));
  }
}
