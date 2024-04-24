import 'package:flutter/material.dart';
import 'package:pdf_view/entity.dart';
import 'package:pdf_view/pdf_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPdfPage(Links().list),
    );
  }
}

