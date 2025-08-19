import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/app_theme.dart';
import 'pages/addstorypage.dart';
import 'pages/editstorypage.dart';
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

// صفحة اختبارية للتنقل إلى AddStoryPage وEditStoryPage
class TestHomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const TestHomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    // كائن Story وهمي لاختبار EditStoryPage
    final mockStory = Story(
      id: 'mock_id',
      title: 'Mock Story',
      author: 'Mock Author',
      pageCount: 100,
      description: 'This is a mock short description.',
      fullDescription: 'This is a mock full description for testing.',
      images: ['/path/to/mock/image.jpg'],
      pdfUrl: 'https://example.com/mock.pdf',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page for Add/Edit Story'),
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
                  MaterialPageRoute(builder: (_) => const AddStoryPage()),
                );
              },
              child: const Text('Go to Add Story Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditStoryPage(story: mockStory),
                  ),
                );
              },
              child: const Text('Go to Edit Story Page'),
            ),
          ],
        ),
      ),
    );
  }
}