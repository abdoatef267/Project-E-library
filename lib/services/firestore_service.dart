import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/story_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// جلب القصص بشكل Stream من مجموعة 'stories'
  Stream<List<Story>> getStories() {
    return _db.collection('stories').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Story.fromFirestore(doc)).toList(),
        );
  }

  /// جلب القصص المفضلة للمستخدم حسب قائمة معرفات القصص
  Future<List<Story>> getFavoriteStories(List<String> favoriteStoryIds) async {
    if (favoriteStoryIds.isEmpty) return [];

    final query = await _db
        .collection('stories')
        .where(FieldPath.documentId, whereIn: favoriteStoryIds)
        .get();

    final stories = query.docs.map((doc) => Story.fromFirestore(doc)).toList();
    return stories;
  }

  /// إضافة أو إزالة قصة من قائمة المفضلة للمستخدم
  Future<void> toggleFavorite(String userId, String storyId, bool isFavorite) async {
    final userDoc = _db.collection('users').doc(userId);

    if (isFavorite) {
      // إزالة القصة من المفضلة
      await userDoc.update({
        'favoriteStories': FieldValue.arrayRemove([storyId])
      });
    } else {
      // إضافة القصة للمفضلة
      await userDoc.set({
        'favoriteStories': FieldValue.arrayUnion([storyId])
      }, SetOptions(merge: true));
    }
  }

  /// حذف قصة معينة حسب معرفها
  Future<void> deleteStory(String storyId) async {
    await _db.collection('stories').doc(storyId).delete();
  }

  /// إضافة قصة جديدة مع توليد معرف تلقائي للوثيقة
  Future<void> addStory(Story story) async {
    final docRef = _db.collection('stories').doc(); // توليد مستند جديد بمعرف تلقائي
    final storyWithId = story.copyWith(id: docRef.id);
    await docRef.set(storyWithId.toMap());
  }
  Future<void> updateStory(Story story) async {
  await _db.collection('stories').doc(story.id).update(story.toMap());
}
}
