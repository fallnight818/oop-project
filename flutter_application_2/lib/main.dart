// main.dart

import 'package:flutter/material.dart';

// 1. Add the import statement for your testimage file
// Adjust the path 'flutter_application_2' if your project name is different
import 'package:flutter_application_2/testimage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // 2. Set MenuOverlay as the home screen
      home: const MenuOverlay(), // Use the widget from testimage.dart
    );
  }
}