# README for Member 1: Authentication and Registration Pages

## Overview
As Member 1, I was responsible for implementing the authentication system in the Flutter project. This includes user login, registration, and related services. The goal was to create secure and user-friendly interfaces for user authentication using Firebase Auth and Firestore.

## Files Implemented
- **login_page.dart**: Handles user login with email and password validation, using AuthBloc for state management.
- **register_page.dart**: Handles user registration with name, email, and password, saving data to Firestore.
- **auth_bloc.dart**: Manages authentication states and events (login, register, logout).
- **auth_event.dart**: Defines authentication events.
- **auth_state.dart**: Defines authentication states.
- **auth_service.dart**: Service layer for Firebase Auth operations (signIn, register, signOut).
- **custom_text_field.dart**: Reusable widget for text fields with validation.
- **form_validator.dart**: Utility for validating form inputs (email, password, name).
- Portions of **app_strings.dart**: Strings related to login and registration (e.g., buttons, labels, errors).

## Key Features
- Form validation for email, password, and name.
- Integration with Firebase Authentication for login and registration.
- Saving user data (name, email) to Firestore upon registration.
- Toast notifications for success and errors using `toast_helper.dart`.
- Navigation to HomePage upon successful login/registration (using callbacks to avoid dependencies).

## Testing
- Tested login and registration flows with mock callbacks for navigation.
- Validated form inputs and error handling.
- Ensured no dependencies on other members' files during development.

## Branch
- Branch: `auth-pages`

## Notes
- Used `Navigator.pushReplacement` with callbacks to handle navigation without direct imports.
- Ready for integration with HomePage from Member 2.