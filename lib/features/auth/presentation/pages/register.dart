import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/button/button_state.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';
import 'package:julybyoma_app/common/widget/custom_rounded_button.dart';
import 'package:julybyoma_app/common/widget/custom_text_field.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/features/auth/data/models/signup_request.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/pages/login.dart';
import 'package:julybyoma_app/features/home/home.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final _regFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_regFormKey.currentState?.validate() ?? false) {
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      debugPrint("Register with $email / $password");

      context.read<ButtonStateCubit>().execute(
        useCase: getIt<SignupUseCase>(),
        params: SignupRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors in red")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonStateCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeWidget()),
                );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _regFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "JulyByOma",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Create your account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Welcome, let's fill in the account details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 40),

                          CustomTextField(
                            headerText: "First Name",
                            controller: _firstNameController,
                            hintText: "Enter your first name",
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? "Enter first name"
                                : null,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            headerText: "Last Name",
                            controller: _lastNameController,
                            hintText: "Enter your last name",
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? "Enter last name"
                                : null,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            headerText: "Email",
                            controller: _emailController,
                            hintText: "Enter your email",
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value != null && value.contains("@")
                                ? null
                                : "Invalid email",
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            headerText: "Password",
                            controller: _passwordController,
                            hintText: "Password",
                            icon: Icons.lock,
                            isPassword: true,
                            validator: (value) =>
                                value != null && value.length >= 6
                                ? null
                                : "Min 6 characters required",
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            headerText: "Confirm Password",
                            controller: _confirmPasswordController,
                            hintText: "Confirm Password",
                            icon: Icons.lock,
                            isPassword: true,
                            validator: (value) =>
                                value != null &&
                                    value == _passwordController.text
                                ? null
                                : "Passwords do not match",
                          ),
                          const SizedBox(height: 30),

                          SizedBox(
                            height: 60,
                            child: CustomRoundedButton(
                              text: "Sign Up",
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () => _submit(context),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
