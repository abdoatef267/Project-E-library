import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/app_strings.dart'; // استيراد AppStrings
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EditProfileBloc() : super(EditProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<EditProfileState> emit) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(EditProfileFailure(AppStrings.msgUserNotLoggedIn)); // استخدام AppStrings
      return;
    }

    emit(EditProfileLoading());

    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data() as Map<String, dynamic>?;

      final nameFromFirestore = (doc.exists && data != null) ? data['name'] as String? : null;
      final displayName = user.displayName ?? nameFromFirestore ?? '';

      emit(EditProfileLoaded(name: displayName, email: user.email ?? ''));
    } catch (e) {
      emit(EditProfileFailure("${AppStrings.msgFailedToLoadUserData}: $e")); // استخدام AppStrings
    }
  }

  Future<void> _onUpdateUserProfile(UpdateUserProfile event, Emitter<EditProfileState> emit) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(EditProfileFailure(AppStrings.msgUserNotLoggedIn)); // استخدام AppStrings
      return;
    }

    emit(EditProfileLoading());

    try {
      if (event.name.trim() != (user.displayName ?? '')) {
        await user.updateDisplayName(event.name.trim());
        await _firestore.collection('users').doc(user.uid).update({'name': event.name.trim()});
      }

      if (event.email.trim() != (user.email ?? '')) {
        await user.verifyBeforeUpdateEmail(event.email.trim());
      }

      if (event.password.isNotEmpty) {
        await user.updatePassword(event.password);
      }

      await user.reload();

      emit(EditProfileSuccess());

      add(LoadUserProfile());
    } on FirebaseAuthException catch (e) {
      emit(EditProfileFailure(e.message ?? AppStrings.msgErrorOccurred)); // استخدام AppStrings
      add(LoadUserProfile());
    } catch (e) {
      emit(EditProfileFailure("${AppStrings.msgErrorOccurred}: $e")); // استخدام AppStrings
      add(LoadUserProfile());
    }
  }
}