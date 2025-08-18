import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/story_model.dart';
import '../services/firestore_service.dart';
import '../constants/app_strings.dart';
import '../utils/toast_helper.dart'; // استيراد ToastHelper
import 'EditStoryPage.dart';
import 'package:page_transition/page_transition.dart';
import 'story_pdf_viewer.dart';

class StoryDetailsPage extends StatefulWidget {
  Story story;
  final bool isAdmin;

  StoryDetailsPage({
    super.key,
    required this.story,
    this.isAdmin = false,
  });

  @override
  State<StoryDetailsPage> createState() => _StoryDetailsPageState();
}

class _StoryDetailsPageState extends State<StoryDetailsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isDeleting = false;

  Future<void> _deleteStory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.titleConfirmDelete),
        content: const Text(AppStrings.msgConfirmDelete),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppStrings.btnCancel)),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(AppStrings.btnDelete)),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _isDeleting = true;
      });

      try {
        await _firestoreService.deleteStory(widget.story.id);
        if (!mounted) return;
        ToastHelper.showToast(AppStrings.toastStoryDeletedSuccess); // استخدام Toast
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isDeleting = false;
        });
        if (mounted) {
          ToastHelper.showToast('${AppStrings.toastErrorOccurred}: $e', isError: true); // استخدام Toast
        }
      }
    }
  }

  Future<void> _launchPDF() async {
    final url = widget.story.pdfUrl;
    if (url.isEmpty) {
      ToastHelper.showToast(AppStrings.toastNoPdfAvailable, isError: true); // استخدام Toast
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      ToastHelper.showToast(AppStrings.toastInvalidPdfUrl, isError: true); // استخدام Toast
      return;
    }

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ToastHelper.showToast(AppStrings.toastFailedToOpenPdf, isError: true); // استخدام Toast
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;

    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
        actions: widget.isAdmin
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: AppStrings.btnEdit,
                  onPressed: () async {
                    final updatedStory = await Navigator.push<Story>(
                      context,
                      PageTransition(type: PageTransitionType.leftToRightWithFade, 
child: EditStoryPage(story: story),duration: const Duration(milliseconds: 1300),
    reverseDuration: const Duration(milliseconds: 1300),)
                    );
                    if (updatedStory != null) {
                      setState(() {
                        widget.story = updatedStory;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: AppStrings.btnDelete,
                  onPressed: _isDeleting ? null : _deleteStory,
                ),
              ]
            : null,
      ),
      body: _isDeleting
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (story.images.isNotEmpty)
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        itemCount: story.images.length,
                        itemBuilder: (context, index) => Image.network(
                          story.images[index],
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    story.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppStrings.labelAuthor}: ${story.author}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${story.pageCount} ${AppStrings.labelPages}', // استخدام AppStrings
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    story.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story.fullDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  if (story.pdfUrl.isNotEmpty)
                    ElevatedButton.icon(
  icon: const Icon(Icons.picture_as_pdf),
  label: Text(AppStrings.btnShowPdf),
  onPressed: () {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.leftToRightWithFade, 
child: StoryPdfViewer(pdfUrl: story.pdfUrl),duration: const Duration(milliseconds: 900),
    reverseDuration: const Duration(milliseconds: 900),)
    );
  },
),
                ],
              ),
            ),
    );
  }
}