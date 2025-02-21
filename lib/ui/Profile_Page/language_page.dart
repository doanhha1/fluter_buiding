import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language')),
      body: const Center(
        child: Text(
          'Language Selection Page - Choose your preferred language.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
