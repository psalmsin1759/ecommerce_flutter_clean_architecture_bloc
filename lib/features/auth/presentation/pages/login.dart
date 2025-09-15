import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julybyoma_app/common/bloc/button/button_state.dart';
import 'package:julybyoma_app/common/bloc/button/button_state_cubit.dart';
import 'package:julybyoma_app/common/widget/custom_rounded_button.dart';
import 'package:julybyoma_app/common/widget/custom_text_field.dart';
import 'package:julybyoma_app/injection.dart';
import 'package:julybyoma_app/features/auth/data/models/login_request.dart';
import 'package:julybyoma_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:julybyoma_app/features/auth/presentation/pages/register.dart';
import 'package:julybyoma_app/features/home/home.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isRemembered = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRememberMe(bool? value) {
    setState(() {
      isRemembered = value ?? false;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      context.read<ButtonStateCubit>().execute(
        useCase: getIt<LoginUseCase>(),
        params: LoginRequest(email: email, password: password),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors in red")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
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
                    "Login to your account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome back. We have missed you!!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),

                  CustomTextField(
                    headerText: "Email",
                    controller: _emailController,
                    hintText: "Enter your email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value != null && value.contains("@")
                        ? null
                        : "Invalid email",
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    headerText: "Password",
                    controller: _passwordController,
                    hintText: "Enter your password",
                    icon: Icons.lock,
                    isPassword: true,
                    validator: (value) => value != null && value.length >= 6
                        ? null
                        : "Min 6 characters required",
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isRemembered,
                            onChanged: _handleRememberMe,
                          ),
                          const Text("Remember me"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  BlocConsumer<ButtonStateCubit, ButtonState>(
                    listener: (context, state) {
                      if (state is ButtonSuccessState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeWidget()),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: 60,
                        child: CustomRoundedButton(
                          text: "Login",
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: _submit,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Or continue with",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon("assets/images/facebook.png"),
                      const SizedBox(width: 10),
                      _buildSocialIcon("assets/images/apple.png"),
                      const SizedBox(width: 10),
                      _buildSocialIcon("assets/images/google.png"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterWidget(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(child: Image.asset(assetPath, width: 40, height: 40)),
    );
  }
}
