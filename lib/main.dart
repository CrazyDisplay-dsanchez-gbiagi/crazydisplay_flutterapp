import 'package:flutter/material.dart';
import 'crazy_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // Set the primary color
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)),
      home: CrazyDisplay(),
    );
  }
}
