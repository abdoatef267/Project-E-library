import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// تسجيل مستخدم جديد مع حفظ بياناته في Firestore وعرض الاسم في FirebaseAuth
  Future<void> register(String name, String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // تحديث displayName في Firebase Authentication
    await userCredential.user?.updateDisplayName(name);

    // حفظ بيانات المستخدم في Firestore مع الاسم
    await _db.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
      'favoriteStories': [], // قائمة المفضلة فارغة عند التسجيل
    });
  }

  /// تسجيل الدخول باستخدام البريد الإلكتروني وكلمة السر
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// تسجيل الخروج من الحساب الحالي
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// المستخدم الحالي إذا كان مسجلاً الدخول، أو null إذا لم يكن هناك مستخدم
  User? get currentUser => _auth.currentUser;
}
