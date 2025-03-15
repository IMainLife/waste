import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  final int userPoints = 320; // Temporary (replace with Firebase later)

  final List<Map<String, dynamic>> rewards = const [
    {
      'title': 'Eco Hero Badge',
      'description': 'Earn a badge and show off your eco journey!',
      'points': 300,
      'type': 'Badge',
    },
    {
      'title': 'Custom Avatar Frame',
      'description': 'Decorate your profile with a cool avatar frame!',
      'points': 400,
      'type': 'Profile Customization',
    },
    {
      'title': 'Tree Donation Certificate',
      'description': 'Symbolic virtual tree donation – help Earth grow 🌱',
      'points': 250,
      'type': 'Tree Donation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "You have $userPoints 🌍 Eco Points",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final canRedeem = userPoints >= reward['points'];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reward['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text(reward['description']),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${reward['points']} Eco Points",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ElevatedButton(
                              onPressed: canRedeem
                                  ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Redeemed: ${reward['title']}")),
                                );
                                // TODO: Save redeem status in Firebase later
                              }
                                  : null,
                              child: Text("Redeem"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canRedeem ? Colors.green : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
