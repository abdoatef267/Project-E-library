import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../utils/form_validator.dart';
import '../utils/toast_helper.dart';
import '../constants/app_strings.dart';
import 'login_page.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const RegisterPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height - 80,
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // العنوان
                Column(
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(AppStrings.titleRegister,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black))),
                    const SizedBox(height: 10),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(AppStrings.createAccount,
                            style: TextStyle(
                                fontSize: 15,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[700]))),
                  ],
                ),

                // الحقول
                Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: _makeInput(
                          label: AppStrings.labelName,
                          controller: nameController,
                          validator: FormValidator.validateName,
                          isDark: isDark),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: _makeInput(
                          label: AppStrings.labelEmail,
                          controller: emailController,
                          validator: FormValidator.validateEmail,
                          isDark: isDark),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: _makeInput(
                          label: AppStrings.labelPassword,
                          controller: passController,
                          validator: FormValidator.validatePassword,
                          obscureText: true,
                          isDark: isDark),
                    ),
                  ],
                ),

                // زر التسجيل
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        ToastHelper.showToast(
                            AppStrings.toastRegistrationSuccess);
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginPage(toggleTheme: toggleTheme),
                              duration:
                                  const Duration(milliseconds: 1300)),
                        );
                      }
                      if (state is AuthFailure) {
                        ToastHelper.showToast(state.error, isError: true);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color:
                                    isDark ? Colors.white : Colors.black)),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(RegisterRequested(
                                  nameController.text,
                                  emailController.text,
                                  passController.text));
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text(AppStrings.btnRegister,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                        ),
                      );
                    },
                  ),
                ),

                // لينك تسجيل الدخول
                FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.haveAccount,
                          style: TextStyle(
                              color:
                                  isDark ? Colors.grey[400] : Colors.black)),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: LoginPage(toggleTheme: toggleTheme),
                                duration:
                                    const Duration(milliseconds: 1300)),
                          );
                        },
                        child: Text(" ${AppStrings.btnLogin}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _makeInput({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
