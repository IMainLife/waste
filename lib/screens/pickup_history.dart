import 'package:flutter/material.dart';

class PickupHistoryScreen extends StatelessWidget {
  const PickupHistoryScreen({Key? key}) : super(key: key);

  // Sample pickup data (replace with Firebase later)
  final List<Map<String, dynamic>> pickupHistory = const [
    {
      'date': '2025-03-10',
      'time': '10:00 AM',
      'wasteType': 'Plastic Waste',
      'status': 'Completed',
    },
    {
      'date': '2025-03-08',
      'time': '2:30 PM',
      'wasteType': 'Food Waste',
      'status': 'Pending',
    },
    {
      'date': '2025-03-05',
      'time': '5:00 PM',
      'wasteType': 'Electronic Waste',
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pickup History"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: pickupHistory.length,
        itemBuilder: (context, index) {
          final pickup = pickupHistory[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.recycling, color: Colors.green),
              title: Text("${pickup['wasteType']}"),
              subtitle: Text("${pickup['date']} at ${pickup['time']}"),
              trailing: Text(
                pickup['status'],
                style: TextStyle(
                  color: pickup['status'] == 'Completed'
                      ? Colors.green
                      : pickup['status'] == 'Pending'
                      ? Colors.orange
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
