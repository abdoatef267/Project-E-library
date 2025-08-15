import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/app_theme.dart';
import 'pages/story_pdf_viewer.dart';
import 'pages/story_details_page.dart';
import 'pages/settings_page.dart';
import 'pages/edit_profile_page.dart';
import 'blocs/edit_profile/edit_profile_bloc.dart';
import 'models/story_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: TestHomePage(toggleTheme: toggleTheme),
    );
  }
}

// صفحة اختبارية للتنقل إلى صفحات العضو الرابع
class TestHomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const TestHomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    // كائن Story وهمي لاختبار StoryDetailsPage وStoryPdfViewer
    final mockStory = Story(
      id: 'mock_id',
      title: 'Mock Story',
      author: 'Mock Author',
      pageCount: 100,
      description: 'This is a mock short description.',
      fullDescription: 'This is a mock full description for testing.',
      images: ['https://via.placeholder.com/150'],
      pdfUrl: 'https://www.example.com/sample.pdf', // رابط PDF وهمي للاختبار
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page for Member 4'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryPdfViewer(pdfUrl: mockStory.pdfUrl),
                  ),
                );
              },
              child: const Text('Go to Story PDF Viewer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryDetailsPage(story: mockStory, isAdmin: true),
                  ),
                );
              },
              child: const Text('Go to Story Details Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsPage(toggleTheme: toggleTheme),
                  ),
                );
              },
              child: const Text('Go to Settings Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfilePage(),
                  ),
                );
              },
              child: const Text('Go to Edit Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}