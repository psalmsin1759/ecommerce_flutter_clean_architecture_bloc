import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/core/get_it/get_it.dart';
import 'package:julybyoma_app/core/theme/app_theme.dart';
import 'package:julybyoma_app/features/auth/presentation/pages/onboardiing_screen.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_events.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    BlocProvider(
      create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.getTheme(
            state.themeEntity?.themeType == ThemeType.dark,
          ),
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
