import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/app_strings.dart'; // استيراد AppStrings
import '../utils/toast_helper.dart'; // استيراد ToastHelper

class StoryPdfViewer extends StatefulWidget {
  final String pdfUrl;
  const StoryPdfViewer({super.key, required this.pdfUrl});

  @override
  State<StoryPdfViewer> createState() => _StoryPdfViewerState();
}

class _StoryPdfViewerState extends State<StoryPdfViewer> {
  late PdfViewerController _pdfViewerController;
  Key pdfKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  void _reloadPdf() {
    setState(() {
      pdfKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pdfUrl.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.titleStoryPdfViewer)), // استخدام AppStrings
        body: Center(
          child: Text(
            AppStrings.msgNoPdfAvailable, // استخدام AppStrings
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleStoryPdfViewer), // استخدام AppStrings
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: 'تكبير',
            onPressed: () {
              double newZoom = _pdfViewerController.zoomLevel + 0.25;
              _pdfViewerController.zoomLevel = newZoom.clamp(1.0, 3.0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: 'تصغير',
            onPressed: () {
              double newZoom = _pdfViewerController.zoomLevel - 0.25;
              _pdfViewerController.zoomLevel = newZoom.clamp(1.0, 3.0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إعادة تحميل',
            onPressed: _reloadPdf,
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        controller: _pdfViewerController,
        key: pdfKey,
        enableTextSelection: true,
        enableDoubleTapZooming: true,
        onDocumentLoadFailed: (details) {
          ToastHelper.showToast('${AppStrings.toastFailedToOpenPdf}: ${details.error}', isError: true); // استخدام Toast
        },
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
      ),
    );
  }
}