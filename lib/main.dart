import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/app_theme.dart';
import 'blocs/auth_bloc.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import "pages/splash_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    _loadTheme(); // 👈 تحميل الثيم من التخزين
  }

  // تحميل الثيم من SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('isDark') ?? false; // لو مش محفوظ، يرجع false
    });
  }

  // تبديل الثيم وحفظه
  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = !isDark;
    });
    await prefs.setBool('isDark', isDark); // 👈 حفظ الاختيار
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (_) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, 
          child: child!,
        );
      },
        home: currentUser == null 
            ? SplashPage(toggleTheme: toggleTheme) 
            : HomePage(toggleTheme: toggleTheme),
      ),
    );
  }
}
