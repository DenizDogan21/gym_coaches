import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';
import 'package:gym_coaches/core/utils/validators.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_button.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_text_field.dart';
import 'package:gym_coaches/presentation/common/widgets/loading_indicator.dart';
import 'package:gym_coaches/presentation/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:gym_coaches/routes.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final authState = ref.watch(authViewModelProvider);
    final viewModel = ref.read(authViewModelProvider.notifier);

    // Hata kontrolü
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = size.width * 0.08;
          double maxFormWidth = 500; // Tablet/Web için maksimum genişlik

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.clamp(16, 40),
              vertical: size.height * 0.03,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: maxFormWidth,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kayıt Ol",
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: size.width < 360 ? 22 : 28,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),

                        /// Ad Soyad
                        CustomTextField(
                          controller: _nameController,
                          hintText: "Ad Soyad",
                          validator: Validators.validateName,
                        ),
                        SizedBox(height: size.height * 0.015),

                        /// Email
                        CustomTextField(
                          controller: _emailController,
                          hintText: "E-posta",
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                        ),
                        SizedBox(height: size.height * 0.015),

                        /// Şifre
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
                        SizedBox(height: size.height * 0.015),

                        /// Şifre Tekrar
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "Şifre Tekrar",
                          obscureText: _obscureConfirmPassword,
                          validator:
                              (value) => Validators.validatePasswordMatch(
                                _passwordController.text,
                                value,
                              ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),

                        /// Kayıt Ol Butonu
                        CustomButton(
                          text: "Kayıt Ol",
                          isLoading: authState.isLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final name = _nameController.text.trim();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              viewModel.signUp(email, password, name);
                            }
                          },
                        ),
                        SizedBox(height: size.height * 0.03),

                        /// Alt Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Zaten hesabınız var mı?"),
                            TextButton(
                              onPressed: () {
                                context.goNamed(AppRoutes.login);
                              },
                              child: const Text("Giriş Yap"),
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
        },
      ),
    );
  }
}
