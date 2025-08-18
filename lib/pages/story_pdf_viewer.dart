import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StoryPdfViewer extends StatelessWidget {
  final String pdfUrl;
  const StoryPdfViewer({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عرض PDF")),
      body: SfPdfViewer.network(pdfUrl), 
    );
  }
}
