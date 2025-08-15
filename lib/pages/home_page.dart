import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../models/story_model.dart';
import '../services/firestore_service.dart';
import '../widgets/story_card.dart';
import '../utils/toast_helper.dart';
import 'favorite_page.dart';

const String ADMIN_UID = "HOrvrHr4kcXR7u8ARaLB0bT52RV2";

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final User? user = FirebaseAuth.instance.currentUser;

  bool _isAdmin = false;
  String _userName = '';
  List<String> favoriteStories = [];
  List<Story> _allStories = [];
  List<Story> _filteredStories = [];
  final TextEditingController _searchController = TextEditingController();

  StreamSubscription<DocumentSnapshot>? _userNameSubscription;

  @override
  void initState() {
    super.initState();
    _determineAdminStatus();
    if (user != null) {
      _userNameSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists && mounted) {
          final data = snapshot.data();
          setState(() {
            _userName = data?['name'] ?? '';
          });
        }
      });
    }
    _loadFavorites();
    _searchController.addListener(_onSearchChanged);
  }

  void _determineAdminStatus() {
    if (user != null && user!.uid == ADMIN_UID) {
      setState(() {
        _isAdmin = true;
      });
    } else {
      setState(() {
        _isAdmin = false;
      });
    }
  }

  Future<void> _loadFavorites() async {
    if (user == null) return;
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (doc.exists && mounted) {
        setState(() {
          favoriteStories = List<String>.from(doc.get('favoriteStories') ?? []);
        });
      }
    } catch (e) {
      ToastHelper.showToast(AppStrings.toastFailedToLoadStories, isError: true);
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredStories = _allStories;
      } else {
        _filteredStories =
            _allStories.where((story) => story.title.toLowerCase().contains(query)).toList();
      }
    });
  }

  void _toggleFavorite(String storyId) async {
    if (user == null) {
      ToastHelper.showToast(AppStrings.toastUserNotLoggedIn, isError: true);
      return;
    }
    final bool isCurrentlyFavorite = favoriteStories.contains(storyId);
    try {
      await _firestoreService.toggleFavorite(user!.uid, storyId, isCurrentlyFavorite);
      setState(() {
        if (isCurrentlyFavorite) {
          favoriteStories.remove(storyId);
          ToastHelper.showToast(AppStrings.toastStoryRemovedFromFavorites);
        } else {
          favoriteStories.add(storyId);
          ToastHelper.showToast(AppStrings.toastStoryAddedToFavorites);
        }
      });
    } catch (e) {
      ToastHelper.showToast('${AppStrings.toastFailedToUpdateFavorites}: $e', isError: true);
    }
  }

  @override
  void dispose() {
    _userNameSubscription?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _userName.isNotEmpty
        ? _userName
        : (user?.email?.split('@')[0] ?? AppStrings.titleHomePage);

    return Scaffold(
      appBar: AppBar(
        title: Text("$displayName - ${AppStrings.titleHomePage}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: AppStrings.titleFavorites,
            onPressed: () {
              // الانتقال إلى FavoritePage (لأنها ضمن مسؤولية العضو الثاني)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritePage(
                    favoriteStories: favoriteStories,
                    toggleTheme: widget.toggleTheme,
                  ),
                ),
              );
            },
          ),
          if (_isAdmin)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: AppStrings.btnAddStory,
              onPressed: () {
                // تعطيل التنقل مؤقتًا
                print("Add Story button pressed (no navigation during development)");
              },
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: AppStrings.titleSettings,
            onPressed: () {
              // تعطيل التنقل مؤقتًا
              print("Settings button pressed (no navigation during development)");
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Story>>(
        stream: _firestoreService.getStories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          _allStories = snapshot.data!;
          if (_searchController.text.isEmpty) {
            _filteredStories = _allStories;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: AppStrings.labelSearchStory,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _filteredStories.isEmpty
                    ? Center(child: Text(AppStrings.msgNoSearchResults))
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _filteredStories.length,
                        itemBuilder: (context, index) {
                          final story = _filteredStories[index];
                          final isFavorite = favoriteStories.contains(story.id);

                          return StoryCard(
                            story: story,
                            isFavorite: isFavorite,
                            onFavoriteToggle: () => _toggleFavorite(story.id),
                            onTap: () {
                              // تعطيل التنقل مؤقتًا
                              print("Story tapped: ${story.title} (no navigation during development)");
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}