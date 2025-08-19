import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../constants/app_strings.dart'; // استيراد AppStrings
import 'login_page.dart';
import 'edit_profile_page.dart';
import 'splash_page.dart';
import 'package:page_transition/page_transition.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const SettingsPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleSettings), // استخدام AppStrings
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(AppStrings.titleEditProfile), // استخدام AppStrings
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: const EditProfilePage(),
                  duration: const Duration(milliseconds: 900),
                  reverseDuration: const Duration(milliseconds: 900),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(AppStrings.btnToggleDarkMode), // استخدام AppStrings
            trailing: const Icon(Icons.brightness_6),
            onTap: toggleTheme,
          ),
          ListTile(
            title: const Text(AppStrings.btnLogout), // استخدام AppStrings
            trailing: const Icon(Icons.logout),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => SplashPage(toggleTheme: toggleTheme),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
