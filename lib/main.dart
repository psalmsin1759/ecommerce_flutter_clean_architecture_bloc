import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:julybyoma_app/common/bloc/auth/auth_state.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/core/theme/app_theme.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state_cubit.dart';
import 'package:julybyoma_app/features/auth/presentation/pages/onboardiing_screen.dart';
import 'package:julybyoma_app/features/home/home.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_events.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>()..add(GetThemeEvent()),
        ),
        BlocProvider<AuthStateCubit>(
          create: (_) => getIt<AuthStateCubit>()..appStarted(),
        ),

        BlocProvider<ButtonStateCubit>(
          create: (_) => getIt<ButtonStateCubit>(),
        ),

        BlocProvider<UserStateCubit>(create: (_) => getIt<UserStateCubit>()),
      ],
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
          home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const HomeWidget();
              }
              if (state is UnAuthenticated) {
                return const OnboardingScreen();
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
