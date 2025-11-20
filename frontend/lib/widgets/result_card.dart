import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: ${data['name']}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('Status: ${data['registration_status']}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

