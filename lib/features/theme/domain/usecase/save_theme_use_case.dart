import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/domain/repository/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future call(ThemeEntity theme) async {
    await themeRepository.saveTheme(theme);
  }
}
