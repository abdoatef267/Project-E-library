abstract class EditProfileEvent {}

class LoadUserProfile extends EditProfileEvent {}

class UpdateUserProfile extends EditProfileEvent {
  final String name;
  final String email;
  final String password;

  UpdateUserProfile({
    required this.name,
    required this.email,
    required this.password,
  });
}
