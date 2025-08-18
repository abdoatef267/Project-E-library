import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../services/firestore_service.dart';
import '../widgets/story_card.dart';
import '../constants/app_strings.dart'; // استيراد AppStrings
import '../utils/toast_helper.dart'; // استيراد ToastHelper
import 'story_details_page.dart';
import 'package:page_transition/page_transition.dart';

class FavoritePage extends StatefulWidget {
  final List<String> favoriteStories;
  final VoidCallback toggleTheme;

  const FavoritePage({
    super.key,
    required this.favoriteStories,
    required this.toggleTheme,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final User? user = FirebaseAuth.instance.currentUser;

  List<Story> _favoriteStoriesData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStories();
  }

  Future<void> _loadFavoriteStories() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.favoriteStories.isEmpty) {
      setState(() {
        _favoriteStoriesData = [];
        _isLoading = false;
      });
      return;
    }

    try {
      final stories = await _firestoreService.getFavoriteStories(widget.favoriteStories);
      setState(() {
        _favoriteStoriesData = stories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _favoriteStoriesData = [];
        _isLoading = false;
      });
      ToastHelper.showToast('${AppStrings.toastFailedToLoadStories}: $e', isError: true);
    }
  }

  void _toggleFavorite(String storyId) async {
  if (user == null) {
    ToastHelper.showToast(AppStrings.toastUserNotLoggedIn, isError: true);
    return;
  }

  final bool isCurrentlyFavorite = widget.favoriteStories.contains(storyId);

  try {
    await _firestoreService.toggleFavorite(user!.uid, storyId, isCurrentlyFavorite);

    setState(() {
      if (isCurrentlyFavorite) {
        // إزالة من القائمة محليًا وتظهر رسالة الحذف فقط
        widget.favoriteStories.remove(storyId);
        _favoriteStoriesData.removeWhere((story) => story.id == storyId);
        ToastHelper.showToast(AppStrings.toastStoryRemovedFromFavorites);
      } else {
        // إضافة للقائمة محليًا بدون رسالة
        widget.favoriteStories.add(storyId);
        // يمكنك تحميل القصة الجديدة إذا أردت أو الانتظار لتحديث آخر
      }
    });
  } catch (e) {
    ToastHelper.showToast('${AppStrings.toastFailedToUpdateFavorites}: $e', isError: true);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleFavorites),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteStoriesData.isEmpty
              ? const Center(child: Text(AppStrings.msgNoFavoriteStories))
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _favoriteStoriesData.length,
                  itemBuilder: (context, index) {
                    final story = _favoriteStoriesData[index];
                    final isFavorite = widget.favoriteStories.contains(story.id);

                    return StoryCard(
                      story: story,
                      isFavorite: isFavorite,
                      onFavoriteToggle: () => _toggleFavorite(story.id),
                      onTap: () {
                        Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: StoryDetailsPage(story: story),
                                duration:
                                    const Duration(milliseconds: 900), // بطيء
                                reverseDuration:
                                    const Duration(milliseconds: 900),
                              ),
                            );
                      },
                    );
                  },
                ),
    );
  }
}
