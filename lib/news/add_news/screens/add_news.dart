import 'package:flutter/material.dart';

class AddNewsScreen extends StatelessWidget {
  const AddNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: const Center(
        child: Text('Add Screen Content'),
      ),
    );
  }
}
