import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/story_model.dart';
import '../services/firestore_service.dart';
import '../constants/app_strings.dart';
import '../utils/toast_helper.dart'; // استيراد ToastHelper

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pageCountController = TextEditingController();
  final TextEditingController _shortDescriptionController = TextEditingController();
  final TextEditingController _fullDescriptionController = TextEditingController();
  final TextEditingController _pdfUrlController = TextEditingController();

  List<XFile> _pickedImages = [];

  bool _isSaving = false;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile>? images = await picker.pickMultiImage(imageQuality: 80);
      if (images != null && images.isNotEmpty) {
        setState(() {
          _pickedImages.addAll(images);
        });
      }
    } catch (e) {
      ToastHelper.showToast('${AppStrings.toastErrorOccurred}: $e', isError: true); // استخدام Toast
    }
  }

  Future<void> _saveStory() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedImages.isEmpty) {
      ToastHelper.showToast(AppStrings.toastAddAtLeastOneImage, isError: true); // استخدام Toast
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      List<String> imageUrls = _pickedImages.map((img) => img.path).toList();

      Story newStory = Story(
        id: '',
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        pageCount: int.parse(_pageCountController.text.trim()),
        description: _shortDescriptionController.text.trim(),
        fullDescription: _fullDescriptionController.text.trim(),
        images: imageUrls,
        pdfUrl: _pdfUrlController.text.trim(),
      );

      await _firestoreService.addStory(newStory);

      if (!mounted) return;
      ToastHelper.showToast(AppStrings.toastStoryAddedSuccess); // استخدام Toast
      Navigator.pop(context);
    } catch (e) {
      ToastHelper.showToast('${AppStrings.toastErrorOccurred}: $e', isError: true); // استخدام Toast
    }

    setState(() {
      _isSaving = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleAddStory),
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
                    const SizedBox(height: 12),
                    if (_pickedImages.isNotEmpty)
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _pickedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.file(
                                File(_pickedImages[index].path),
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_photo_alternate),
                      label: Text(AppStrings.btnAddPhotos),
                      onPressed: _pickImages,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveStory,
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