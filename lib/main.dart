import 'package:flutter/material.dart';
import 'package:learning_pathway_list/src/ui/screens/learn_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LearnScreen(),
    );
  }
}
