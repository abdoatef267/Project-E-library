import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../utils/form_validator.dart';
import '../widgets/custom_text_field.dart';
import '../constants/app_strings.dart';
import '../utils/toast_helper.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const LoginPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isDark = Theme.of(context).brightness == Brightness.dark; // تحديد حالة الثيم

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? Colors.black : Colors.white, // دعم الثيم للخلفية
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // 🟢 العنوان
                    Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Text(
                            AppStrings.titleLogin,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black, // دعم الثيم
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            AppStrings.deslogin,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark ? Colors.grey[400] : Colors.grey[700], // دعم الثيم
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 🟢 الحقول
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: CustomTextField(
                              controller: emailController,
                              label: AppStrings.labelEmail,
                              validator: FormValidator.validateEmail,
                              isDark: isDark, // تمرير حالة الثيم إلى CustomTextField
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: CustomTextField(
                              controller: passController,
                              label: AppStrings.labelPassword,
                              isPassword: true,
                              validator: FormValidator.validatePassword,
                              isDark: isDark, // تمرير حالة الثيم إلى CustomTextField
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 🟢 زر تسجيل الدخول
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthSuccess) {
                              ToastHelper.showToast(state.message);
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rotate,
                                  alignment: Alignment.center,
                                  child: HomePage(toggleTheme: toggleTheme),
                                  duration: const Duration(milliseconds: 1400),
                                  reverseDuration:
                                      const Duration(milliseconds: 1400),
                                ),
                              );
                            }
                            if (state is AuthFailure) {
                              ToastHelper.showToast(state.error, isError: true);
                            }
                          },
                          builder: (context, state) {
                            return state is AuthLoading
                                ? const CircularProgressIndicator()
                                : Container(
                                    padding:
                                        const EdgeInsets.only(top: 3, left: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: isDark ? Colors.white : Colors.black, // دعم الثيم
                                      ),
                                    ),
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 60,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                                LoginRequested(
                                                  emailController.text,
                                                  passController.text,
                                                ),
                                              );
                                        }
                                      },
                                      color: Colors.greenAccent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        AppStrings.btnLogin,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: isDark ? Colors.black : Colors.black, // دعم الثيم
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    // 🟢 زر التسجيل
                    FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppStrings.donthave,
                            style: TextStyle(
                              color: isDark ? Colors.grey[400] : Colors.black, // دعم الثيم
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: RegisterPage(toggleTheme: toggleTheme),
                                  duration: const Duration(milliseconds: 1300),
                                ),
                              );
                            },
                            child: Text(
                              AppStrings.btnRegister,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black, // دعم الثيم
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // 🟢 صورة خلفية
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}