import 'package:flutter/material.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contract')),
      body: const Center(
        child: Text(
          'Contract Page - View your contracts here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
