import 'package:flutter/material.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> badges = const [
    {'title': 'Eco Hero', 'date': '2025-03-12'},
    {'title': 'Plastic Recycler Pro', 'date': '2025-03-10'},
    {'title': 'Waste Warrior', 'date': '2025-03-05'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Badges"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.emoji_events, color: Colors.amber),
              title: Text(badge['title'] ?? ''),
              subtitle: Text("Earned on: ${badge['date']}"),
            ),
          );
        },
      ),
    );
  }
}
