import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/edit_profile/edit_profile_bloc.dart';
import '../blocs/edit_profile/edit_profile_event.dart';
import '../blocs/edit_profile/edit_profile_state.dart';
import '../constants/app_strings.dart'; // استيراد AppStrings
import '../utils/toast_helper.dart'; // استيراد ToastHelper

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileBloc()..add(LoadUserProfile()),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    context.read<EditProfileBloc>().stream.listen((state) {
      if (state is EditProfileLoaded) {
        _nameController.text = state.name;
        _emailController.text = state.email;
      }
      if (state is EditProfileSuccess) {
        _passwordController.clear();
        ToastHelper.showToast(AppStrings.toastProfileUpdatedSuccess); // استخدام Toast
      }
      if (state is EditProfileFailure) {
        ToastHelper.showToast("${AppStrings.toastErrorOccurred}: ${state.error}", isError: true); // استخدام Toast
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<EditProfileBloc>().add(UpdateUserProfile(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleEditProfile)), // استخدام AppStrings
      body: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: AppStrings.labelName), // استخدام AppStrings
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.msgEnterName; // استخدام AppStrings
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: AppStrings.labelEmail), // استخدام AppStrings
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.errEnterEmail; // استخدام AppStrings
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return AppStrings.msgInvalidEmailFormat; // استخدام AppStrings
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: AppStrings.labelPasswordOptional), // استخدام AppStrings
                    obscureText: true,
                    validator: (value) {
                      if (value != null && value.isNotEmpty && value.length < 6) {
                        return AppStrings.msgPasswordTooShort; // استخدام AppStrings
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: state is EditProfileLoading ? null : _onSubmit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(AppStrings.btnSave, style: TextStyle(fontSize: 16)), // استخدام AppStrings
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}