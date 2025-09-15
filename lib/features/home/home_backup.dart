import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/button/button_state.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';
import 'package:julybyoma_app/core/get_it/get_it.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state.dart';
import 'package:julybyoma_app/features/auth/presentation/bloc/user_state_cubit.dart';
import 'package:julybyoma_app/features/auth/presentation/pages/login.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_events.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';

class HomeBackupWidget extends StatefulWidget {
  const HomeBackupWidget({super.key});

  @override
  State<HomeBackupWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeBackupWidget> {
  @override
  void initState() {
    super.initState();

    context.read<UserStateCubit>().execute(useCase: getIt<GetUserUseCase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeEntity?.themeType == ThemeType.dark;

        return Scaffold(
          appBar: AppBar(
            title: const Text("JulyByOma"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // USER DETAILS
                BlocBuilder<UserStateCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserLoaded) {
                      final user = state.user;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ID: ${user.id}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Name: ${user.firstName} ${user.lastName}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Email: ${user.email}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    } else if (state is UserError) {
                      return Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                const Divider(),

                // TOGGLE THEME
                ElevatedButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                  child: const Text("Toggle Theme"),
                ),

                // LOGOUT
                BlocConsumer<ButtonStateCubit, ButtonState>(
                  listener: (context, state) {
                    if (state is ButtonSuccessState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginWidget(),
                        ),
                      );
                    } else if (state is ButtonFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<ButtonStateCubit>().execute(
                          useCase: getIt<LogoutUseCase>(),
                        );
                      },
                      child: const Text("Logout"),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
