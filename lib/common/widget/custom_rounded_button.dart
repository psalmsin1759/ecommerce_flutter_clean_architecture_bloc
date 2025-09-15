import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/button/button_state.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;
  final Color textColor;
  final double radius;

  const CustomRoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.textColor = Colors.white,
    this.radius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ButtonStateCubit, ButtonState>(
      listener: (context, state) {
        if (state is ButtonFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        /*  if (state is ButtonSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Action successful")));
        } */
      },
      builder: (context, state) {
        final isLoading = state is ButtonLoadingState;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
