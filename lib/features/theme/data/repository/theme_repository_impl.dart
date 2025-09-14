import 'package:julybyoma_app/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<ThemeEntity> getTheme() async {
    return await themeLocalDatasource.getTheme();
  }

  @override
  Future saveTheme(ThemeEntity theme) async {
    await themeLocalDatasource.saveTheme(theme);
  }
}
