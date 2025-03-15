import 'package:flutter/material.dart';

class MyRewardsScreen extends StatefulWidget {
  const MyRewardsScreen({Key? key}) : super(key: key);

  @override
  State<MyRewardsScreen> createState() => _MyRewardsScreenState();
}

class _MyRewardsScreenState extends State<MyRewardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> badges = [
    {'title': 'Eco Hero', 'date': '2025-03-12'},
    {'title': 'Plastic Recycler Pro', 'date': '2025-03-10'},
  ];

  final List<Map<String, dynamic>> customizations = [
    {'name': 'Gold Avatar Frame', 'unlocked': true},
    {'name': 'Green Leaf Frame', 'unlocked': true},
  ];

  final List<Map<String, String>> treeCertificates = [
    {'title': 'Tree Donation #1', 'date': '2025-03-05'},
    {'title': 'Tree Donation #2', 'date': '2025-03-14'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Rewards"),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Badges'),
            Tab(text: 'Profile'),
            Tab(text: 'Trees'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Badges
          ListView.builder(
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

          // Tab 2: Profile Customizations
          ListView.builder(
            itemCount: customizations.length,
            itemBuilder: (context, index) {
              final item = customizations[index];
              return Card(
                margin: EdgeInsets.all(12),
                child: ListTile(
                  leading: Icon(Icons.brush, color: Colors.purple),
                  title: Text(item['name']),
                  trailing: item['unlocked']
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : Text("Locked", style: TextStyle(color: Colors.red)),
                ),
              );
            },
          ),

          // Tab 3: Tree Certificates
          ListView.builder(
            itemCount: treeCertificates.length,
            itemBuilder: (context, index) {
              final cert = treeCertificates[index];
              return Card(
                margin: EdgeInsets.all(12),
                child: ListTile(
                  leading: Icon(Icons.eco, color: Colors.teal),
                  title: Text(cert['title'] ?? ''),
                  subtitle: Text("Donated on: ${cert['date']}"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
