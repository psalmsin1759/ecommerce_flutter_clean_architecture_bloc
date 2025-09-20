import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:julybyoma_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';
import 'package:julybyoma_app/core/network/dio_client.dart';
import 'package:julybyoma_app/core/network/network_info.dart';
import 'package:julybyoma_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:julybyoma_app/features/auth/data/source/auth_api_service.dart';
import 'package:julybyoma_app/features/auth/data/source/auth_local_service.dart';
import 'package:julybyoma_app/features/auth/domain/repository/auth_repository.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/is_logged_in.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/save_user_usecase.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state_cubit.dart';
import 'package:julybyoma_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:julybyoma_app/features/category/domain/repository/category_respository.dart';
import 'package:julybyoma_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:julybyoma_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:julybyoma_app/features/product/data/sources/product_local_data_source.dart';
import 'package:julybyoma_app/features/product/data/sources/product_remote_data_source.dart';
import 'package:julybyoma_app/features/product/domain/repositories/product_repository.dart';
import 'package:julybyoma_app/features/product/domain/usecases/add_review_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_featured_products_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_product_by_id_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_product_usecase.dart';
import 'package:julybyoma_app/features/product/domain/usecases/get_products_by_category_usecase.dart';
import 'package:julybyoma_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:julybyoma_app/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:julybyoma_app/features/theme/data/repository/theme_repository_impl.dart';
import 'package:julybyoma_app/features/theme/domain/repository/theme_repository.dart';
import 'package:julybyoma_app/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:julybyoma_app/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<ThemeLocalDatasource>(
    ThemeLocalDatasource(sharedPreferences: getIt()),
  );

  getIt.registerSingleton<ThemeRepository>(
    ThemeRepositoryImpl(themeLocalDatasource: getIt()),
  );

  getIt.registerSingleton<GetThemeUseCase>(
    GetThemeUseCase(themeRepository: getIt()),
  );

  getIt.registerSingleton<SaveThemeUseCase>(
    SaveThemeUseCase(themeRepository: getIt()),
  );

  getIt.registerFactory<ThemeBloc>(
    () => ThemeBloc(getThemeUseCase: getIt(), saveThemeUseCase: getIt()),
  );

  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<AuthApiService>(AuthApServiceImpl());

  getIt.registerSingleton<SignupUseCase>(SignupUseCase());

  getIt.registerSingleton<LoginUseCase>(LoginUseCase());

  getIt.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  getIt.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase());

  getIt.registerFactory<AuthStateCubit>(() => AuthStateCubit());

  getIt.registerFactory<ButtonStateCubit>(() => ButtonStateCubit());

  getIt.registerFactory<UserStateCubit>(() => UserStateCubit());

  getIt.registerSingleton<SaveUserUseCase>(SaveUserUseCase());

  getIt.registerSingleton<GetUserUseCase>(GetUserUseCase());

  getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: getIt<ProductRemoteDataSource>(),
      localDataSource: getIt<ProductLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  getIt.registerSingleton<AddReviewUseCase>(AddReviewUseCase());
  getIt.registerSingleton<GetFeaturedProductsUseCase>(
    GetFeaturedProductsUseCase(),
  );
  getIt.registerSingleton<GetProductByIdUseCase>(GetProductByIdUseCase());

  getIt.registerSingleton<GetProductsUseCase>(GetProductsUseCase());

  getIt.registerSingleton<GetProductsByCategoryUseCase>(
    GetProductsByCategoryUseCase(),
  );

  getIt.registerFactory(
    () => ProductBloc(
      getFeaturedProducts: getIt<GetFeaturedProductsUseCase>(),
      getProductById: getIt<GetProductByIdUseCase>(),
      getProducts: getIt<GetProductsUseCase>(),
      getProductsByCategory: getIt<GetProductsByCategoryUseCase>(),
    ),
  );
}
