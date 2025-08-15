import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../constants/app_strings.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const SettingsPage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleSettings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(AppStrings.titleEditProfile),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            ),
          ),
          ListTile(
            title: const Text(AppStrings.btnToggleDarkMode),
            trailing: const Icon(Icons.brightness_6),
            onTap: toggleTheme,
          ),
          ListTile(
            title: const Text(AppStrings.btnLogout),
            trailing: const Icon(Icons.logout),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
              print("Logout button pressed (no navigation to LoginPage during development)");
            },
          ),
        ],
      ),
    );
  }
}