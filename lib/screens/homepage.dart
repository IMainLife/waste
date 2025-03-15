import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile.dart';
import 'leaderboard.dart';
import 'schedule.dart';
import 'challenges.dart';
import 'faq.dart';
import 'notifications.dart';
import 'settings.dart';
import 'rewards.dart';
import 'my_rewards.dart';
import 'achievements.dart';
import 'pickwaste.dart';
import 'signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int ecoPoints = 0;
  int level = 1;
  String name = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data on page load
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        name = userDoc['name'];
        ecoPoints = userDoc['ecoPoints'];
        level = userDoc['level'];
        isLoading = false; // Stop loading once data is fetched
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User data not found in Firestore.")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              accountName: Text(name),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.email ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'EcoTrack',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Eco Level Section
            isLoading
                ? CircularProgressIndicator() // Show loading spinner
                : Column(
              children: [
                Text(
                  'Level $level - Eco Hero 🌱',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: ecoPoints / 1000, // Display progress based on ecoPoints
                  minHeight: 6,
                  color: Colors.green,
                  backgroundColor: Colors.green[100],
                ),
                SizedBox(height: 4),
                Text('$ecoPoints XP / 1000 XP',
                    style: TextStyle(fontSize: 13, color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 20),

            // Eco Points Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'You have',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$ecoPoints 🌍 Eco Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RewardsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Redeem Rewards'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRewardsScreen()),
                );
              },
              icon: Icon(Icons.card_giftcard),
              label: Text("View My Rewards"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF03A9F4), // Sky Blue
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: Size(double.infinity, 48),
              ),
            ),

            // More Services Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'More services',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Pick Waste Icon
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PickWasteScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.delete_outline, size: 30),
                      SizedBox(height: 5),
                      Text('Pick Waste', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                // Redeem Icon
                Column(
                  children: [
                    Icon(Icons.card_giftcard_outlined, size: 30),
                    SizedBox(height: 5),
                    Text('Redeem', style: TextStyle(fontSize: 12)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AchievementsScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.emoji_events_outlined, size: 30),
                      SizedBox(height: 5),
                      Text('Achievements', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            // Buttons Section
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesScreen()),
                );
              },
              icon: Icon(Icons.emoji_objects_outlined),
              label: Text('View Challenges'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                );
              },
              icon: Icon(Icons.leaderboard),
              label: Text('View Leaderboard'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulePickupScreen()),
                );
              },
              icon: Icon(Icons.schedule),
              label: Text('Schedule Collection'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
