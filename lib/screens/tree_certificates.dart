import 'package:flutter/material.dart';

class TreeCertificatesScreen extends StatelessWidget {
  const TreeCertificatesScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> certificates = const [
    {'title': 'Tree Donation #1', 'date': '2025-03-05'},
    {'title': 'Tree Donation #2', 'date': '2025-03-14'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tree Donation Certificates"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: certificates.length,
        itemBuilder: (context, index) {
          final cert = certificates[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.eco, color: Colors.green),
              title: Text(cert['title'] ?? ''),
              subtitle: Text("Donated on: ${cert['date']}"),
            ),
          );
        },
      ),
    );
  }
}
