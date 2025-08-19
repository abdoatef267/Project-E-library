// auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  final String load;
  AuthLoading(this.load);

}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
