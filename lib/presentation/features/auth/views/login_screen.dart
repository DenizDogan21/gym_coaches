import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_coaches/core/utils/validators.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_button.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_text_field.dart';
import 'package:gym_coaches/presentation/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:gym_coaches/routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final viewModel = ref.read(authViewModelProvider.notifier);
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
      if (!next.isLoading && next.isAuthenticated) {
        context.goNamed(AppRoutes.dashboard);
      }
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = size.width * 0.08;
          double maxFormWidth = 500;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.clamp(16, 40), // min/max sınır
              vertical: 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: maxFormWidth,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize:
                              size.width < 360 ? 22 : 28, // mobilde küçült
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      CustomTextField(
                        controller: _emailController,
                        hintText: "E-posta",
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: size.height * 0.015),

                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Şifre",
                        obscureText: _obscurePassword,
                        validator: Validators.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      CustomButton(
                        text: 'Giriş Yap',
                        isLoading: authState.isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            viewModel.signIn(email, password);
                          }
                        },
                      ),

                      SizedBox(height: size.height * 0.03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.goNamed(AppRoutes.forgotPassword);
                            },
                            child: const Text("Şifremi Unuttum"),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {
                              context.goNamed(AppRoutes.register);
                            },
                            child: const Text("Kayıt Ol"),
                          ),
                        ],
                      ),
                    ],
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
