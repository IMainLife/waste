import 'package:flutter/material.dart';

class ProfileCustomizationsScreen extends StatelessWidget {
  const ProfileCustomizationsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> customizations = const [
    {'name': 'Gold Avatar Frame', 'unlocked': true},
    {'name': 'Green Leaf Frame', 'unlocked': false},
    {'name': 'Eco Glow Frame', 'unlocked': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Customizations"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: customizations.length,
        itemBuilder: (context, index) {
          final item = customizations[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(Icons.person_pin_circle, color: Colors.green),
              title: Text(item['name']),
              trailing: item['unlocked']
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Text("Locked", style: TextStyle(color: Colors.red)),
            ),
          );
        },
      ),
    );
  }
}
