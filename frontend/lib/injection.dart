import 'package:get_it/get_it.dart';

import 'core/api/api_client.dart';
import 'features/authentication/data/datasources/auth_remote_ds.dart';
import 'features/authentication/data/repositories/auth_repo_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/register.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

/// Khởi tạo toàn bộ dependency.
/// Gọi `await initDI();` trước `runApp`.
Future<void> initDI() async {
  // ---------- CORE ----------
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // ---------- DATA ----------
  sl.registerLazySingleton<AuthRemoteDS>(() => AuthRemoteDS(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(sl()));

  // ---------- DOMAIN ----------
  sl.registerLazySingleton<LoginUC>(() => LoginUC(sl()));
  sl.registerLazySingleton<RegisterUC>(() => RegisterUC(sl()));

  // ---------- PRESENTATION ----------
  // Bloc là factory (mỗi lần get() cho instance mới)
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
}
