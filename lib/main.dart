import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/app_theme.dart';
import 'blocs/auth_bloc.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

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

  void toggleTheme() {
    setState(() => isDark = !isDark);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: LoginPage(toggleTheme: toggleTheme),
      ),
    );
  }
}