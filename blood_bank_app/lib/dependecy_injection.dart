import 'package:blood_bank_app/cubit/signin_cubit/signin_cubit.dart';
import 'package:blood_bank_app/data/repositories/sign_in_repository_impl.dart';
import 'package:blood_bank_app/domain/repositories/sign_in_repository.dart';
import 'package:blood_bank_app/domain/usecases/sign_in_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => SingInCubit(signInUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));

  // Repositories
  sl.registerLazySingleton<SignInRepository>(() => SignInRepositoryImpl());

  // External
}
