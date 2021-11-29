import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../layout/custom_background.dart';
import 'package:printing/printing.dart';

class PDFViewerScreen extends StatefulWidget {
  final String teamName;
  final Uint8List document;

  const PDFViewerScreen({
    Key? key,
    required this.teamName,
    required this.document,
  }) : super(key: key);

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Récapitulatif projet : ${widget.teamName}"),
      ),
      body: CustomBackground(
        PdfPreview(
          loadingWidget: const CircularProgressIndicator(),
          maxPageWidth: 750,
          build: (format) => widget.document,
        ),
      ),
    );
  }
}
