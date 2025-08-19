import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../services/firestore_service.dart';
import '../constants/app_strings.dart';
import '../utils/toast_helper.dart'; // استيراد ToastHelper

class EditStoryPage extends StatefulWidget {
  final Story story;

  const EditStoryPage({super.key, required this.story});

  @override
  State<EditStoryPage> createState() => _EditStoryPageState();
}

class _EditStoryPageState extends State<EditStoryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _pageCountController;
  late TextEditingController _shortDescriptionController;
  late TextEditingController _fullDescriptionController;
  late TextEditingController _pdfUrlController;

  bool _isSaving = false;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.story.title);
    _authorController = TextEditingController(text: widget.story.author);
    _pageCountController = TextEditingController(text: widget.story.pageCount.toString());
    _shortDescriptionController = TextEditingController(text: widget.story.description);
    _fullDescriptionController = TextEditingController(text: widget.story.fullDescription);
    _pdfUrlController = TextEditingController(text: widget.story.pdfUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pageCountController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _pdfUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveEdits() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() { _isSaving = true; });

    try {
      final updatedStory = widget.story.copyWith(
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        pageCount: int.parse(_pageCountController.text.trim()),
        description: _shortDescriptionController.text.trim(),
        fullDescription: _fullDescriptionController.text.trim(),
        pdfUrl: _pdfUrlController.text.trim(),
      );

      await _firestoreService.updateStory(updatedStory);

      if (!mounted) return;

      ToastHelper.showToast(AppStrings.toastStorySaveSuccess); // استخدام Toast
      Navigator.pop(context, updatedStory);
    } catch (e) {
      setState(() { _isSaving = false; });
      ToastHelper.showToast('${AppStrings.toastErrorOccurred}: $e', isError: true); // استخدام Toast
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleEditStory),
      ),
      body: _isSaving
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelTitle,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? AppStrings.errEnterTitle : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _authorController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelAuthor,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? AppStrings.errEnterAuthor : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pageCountController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelPageCount,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return AppStrings.errEnterPageCount;
                        if (int.tryParse(value.trim()) == null) return AppStrings.errInvalidPageCount;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _shortDescriptionController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelShortDescription,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? AppStrings.errEnterShortDescription : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _fullDescriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelFullDescription,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty ? AppStrings.errEnterFullDescription : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pdfUrlController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.labelPdfUrl,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return null;
                        final urlPattern = r'^(http|https)://';
                        final regExp = RegExp(urlPattern);
                        if (!regExp.hasMatch(value.trim())) {
                          return AppStrings.errEnterValidUrl;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveEdits,
                        child: Text(AppStrings.btnSave),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}