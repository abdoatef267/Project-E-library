import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../utils/form_validator.dart';
import '../widgets/custom_text_field.dart';
import '../constants/app_strings.dart'; // استيراد AppStrings
import '../utils/toast_helper.dart'; // استيراد ToastHelper
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const LoginPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleLogin)), // استخدام AppStrings
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: emailController,
                label: AppStrings.labelEmail, // استخدام AppStrings
                validator: FormValidator.validateEmail,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: passController,
                label: AppStrings.labelPassword, // استخدام AppStrings
                isPassword: true,
                validator: FormValidator.validatePassword,
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ToastHelper.showToast(AppStrings.toastLoginSuccess); // استخدام Toast
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPage(toggleTheme: toggleTheme)),
                    );
                  }
                  if (state is AuthFailure) {
                    ToastHelper.showToast(state.error, isError: true); // استخدام Toast
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    LoginRequested(
                                        emailController.text,
                                        passController.text),
                                  );
                            }
                          },
                          child: const Text(AppStrings.btnLogin), // استخدام AppStrings
                        );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RegisterPage(toggleTheme: toggleTheme)));
                },
                child: const Text(AppStrings.btnRegister), // استخدام AppStrings
              ),
            ],
          ),
        ),
      ),
    );
  }
}