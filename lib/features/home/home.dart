import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/features/theme/domain/entity/theme_entity.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_events.dart';
import 'package:julybyoma_app/features/theme/presentation/bloc/theme_state.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                  child: const Text("Toggle Theme"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
