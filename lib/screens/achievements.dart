import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final String description;
  final bool isUnlocked;

  Achievement({
    required this.title,
    required this.description,
    required this.isUnlocked,
  });
}

class AchievementsScreen extends StatelessWidget {


  final List<Achievement> achievements = [
    Achievement(
      title: '♻️ First Waste Pickup',
      description: 'Complete your first waste pickup.',
      isUnlocked: true,
    ),
    Achievement(
      title: '🪣 Recycle Master',
      description: 'Complete 10 waste pickups.',
      isUnlocked: false,
    ),
    Achievement(
      title: '🗑 Waste Warrior',
      description: 'Recycle 5 different types of waste.',
      isUnlocked: true,
    ),
    Achievement(
      title: '🔥 Challenge Finisher',
      description: 'Complete 5 recycling challenges.',
      isUnlocked: false,
    ),
    Achievement(
      title: '🎯 Eco Point Collector',
      description: 'Earn 1000 total Eco Points.',
      isUnlocked: true,
    ),
    Achievement(
      title: '🌍 Tree Supporter',
      description: 'Redeem 3 Tree Donation Certificates.',
      isUnlocked: false,
    ),
    Achievement(
      title: '🏆 Top Recycler Rank',
      description: 'Enter the top 10 on the leaderboard.',
      isUnlocked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              leading: Icon(
                achievement.isUnlocked ? Icons.emoji_events : Icons.lock_outline,
                color: achievement.isUnlocked ? Colors.amber : Colors.grey,
                size: 32,
              ),
              title: Text(
                achievement.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: achievement.isUnlocked ? Colors.black : Colors.grey,
                ),
              ),
              subtitle: Text(
                achievement.description,
                style: TextStyle(
                  color: achievement.isUnlocked ? Colors.black87 : Colors.grey,
                ),
              ),
              trailing: achievement.isUnlocked
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
