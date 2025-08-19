import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../constants/app_strings.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
  print("LoginRequested received");
  emit(AuthLoading("جاري تسجيل الدخول..."));
  try {
    await _authService.signIn(event.email, event.password);
    print("Login success");
    emit(AuthSuccess(AppStrings.toastLoginSuccess));
  } catch (e) {
    print("Login failed: $e");
    emit(AuthFailure(AppStrings.toastErrorOccurred));
  }
});


    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading("جاري إنشاء الحساب..."));
      try {
        await _authService.register(event.name, event.email, event.password);
        emit(AuthSuccess(AppStrings.toastRegistrationSuccess));
      } catch (e) {
        emit(AuthFailure(AppStrings.toastErrorOccurred));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading("جاري تسجيل الخروج..."));
      await _authService.signOut();
      emit(AuthSuccess(AppStrings.toastLogoutSuccess));
    });
  }
}
