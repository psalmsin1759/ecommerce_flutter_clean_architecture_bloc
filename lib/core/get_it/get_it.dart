import 'package:get_it/get_it.dart';
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
}
