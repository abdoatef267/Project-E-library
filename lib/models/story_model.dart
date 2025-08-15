import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String title;
  final String author;
  final int pageCount;
  final String description;       // وصف قصير
  final String fullDescription;   // وصف طويل أو كامل
  final List<String> images;      // روابط الصور
  final String pdfUrl;            // رابط ملف PDF إن وجد

  Story({
    required this.id,
    required this.title,
    required this.author,
    required this.pageCount,
    required this.description,
    required this.fullDescription,
    required this.images,
    required this.pdfUrl,
  });

  /// دالة copyWith لإنشاء نسخة من الكائن مع تحديث بعض الحقول
  Story copyWith({
    String? id,
    String? title,
    String? author,
    int? pageCount,
    String? description,
    String? fullDescription,
    List<String>? images,
    String? pdfUrl,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      pageCount: pageCount ?? this.pageCount,
      description: description ?? this.description,
      fullDescription: fullDescription ?? this.fullDescription,
      images: images ?? this.images,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }

  /// تحويل كائن Story إلى Map لحفظه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'pageCount': pageCount,
      'description': description,
      'fullDescription': fullDescription,
      'images': images,
      'pdfUrl': pdfUrl,
    };
  }

  /// إنشاء كائن Story من مستند Firestore
  factory Story.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return Story(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      pageCount: data['pageCount'] ?? 0,
      description: data['description'] ?? '',
      fullDescription: data['fullDescription'] ?? '',
      images: List<String>.from((data['images'] ?? []) as List<dynamic>),
      pdfUrl: data['pdfUrl'] ?? '',
    );
  }
}
