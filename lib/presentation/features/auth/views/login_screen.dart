import 'package:flutter/material.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_button.dart';
import 'package:gym_coaches/presentation/common/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.largePadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: AppConstants.mediumPadding),

                      /// Email
                      CustomTextField(
                        controller: _emailController,
                        hintText: "E-posta",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.emptyEmailError;
                          }
                          if (!value.contains("@")) {
                            return AppConstants.invalidEmailError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppConstants.smallPadding),

                      /// Şifreyi göster/gizle
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Text(
                            _obscurePassword
                                ? 'Şifreyi Göster'
                                : 'Şifreyi Gizle',
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConstants.smallPadding),

                      /// Şifre
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Şifre",
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.emptyPasswordError;
                          }
                          if (value.length < 6) {
                            return AppConstants.shortPasswordError;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppConstants.mediumPadding),

                      /// Giriş Yap Butonu
                      CustomButton(
                        text: 'Giriş Yap',
                        // isLoading: loginState.isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(loginControllerProvider.notifier)
                                .login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                          }
                        },
                      ),

                      const SizedBox(height: AppConstants.mediumPadding),

                      /// Alt Linkler
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text("Şifremi Unuttum"),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
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
