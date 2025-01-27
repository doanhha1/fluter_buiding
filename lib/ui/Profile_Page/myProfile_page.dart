import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: const Center(
        child: Text(
          'My Profile Page - Here you can edit your details.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
