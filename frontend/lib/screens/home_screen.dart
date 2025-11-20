import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = 'Waiting for NFC...';
  String? nfcId;
  Map<String, dynamic>? userData;

  // Simulate an NFC scan (since Chromebook can't do NFC)
  void simulateNfc() async {
    setState(() => status = 'Simulating NFC...');
    await Future.delayed(const Duration(seconds: 1));
    onNfcScanned('TEST123456'); // fake NFC tag ID
  }

  // When an NFC tag is "read"
  void onNfcScanned(String tagId) async {
    setState(() {
      nfcId = tagId;
      status = 'Scanning complete. Fetching data...';
    });

    try {
      final response =
          await http.get(Uri.parse('http://localhost:5001/check/$tagId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data;
          status = 'Data retrieved successfully!';
        });
      } else {
        setState(() => status = 'Tag not found or server error.');
      }
    } catch (e) {
      setState(() => status = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASD Registration Check'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(status, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: simulateNfc,
                child: const Text('Simulate NFC Scan'),
              ),
              if (userData != null) ...[
                const SizedBox(height: 30),
                Text(
                  'User Info:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text('Name: ${userData!['name']}'),
                Text('ID: ${userData!['id']}'),
                Text('Status: ${userData!['status']}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
