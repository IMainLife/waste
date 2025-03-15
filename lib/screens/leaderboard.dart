import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy leaderboard data
    final leaderboard = [
      {'name': 'LovesWire', 'points': 3240},
      {'name': 'MafiaSporty', 'points': 3230},
      {'name': 'Karametso', 'points': 3098},
      {'name': 'Arynesat', 'points': 3200},
      {'name': 'ChirpApril', 'points': 3160},
      {'name': 'GoldPod', 'points': 3042},
      {'name': 'NickName5', 'points': 3100},
      {'name': 'YourName', 'points': 890}, // Example: your score
    ];

    // Simulate sorted list
    leaderboard.sort((a, b) =>
        ((b['points'] ?? 0) as int).compareTo((a['points'] ?? 0) as int));



    // Find user's position
    final myIndex = leaderboard.indexWhere((user) => user['name'] == 'YourName');
    final myRank = myIndex + 1;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Leaderboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Recyclers (Podium)
            Text(
              '🏆 Top Recyclers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 2nd
                _podiumBox(rank: 2, user: leaderboard.length > 1 ? leaderboard[1] : null),
                // 1st
                _podiumBox(rank: 1, user: leaderboard.length > 0 ? leaderboard[0] : null),
                // 3rd
                _podiumBox(rank: 3, user: leaderboard.length > 2 ? leaderboard[2] : null),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  final user = leaderboard[index];
                  bool isCurrentUser = user['name'] == 'YourName';

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.green.withOpacity(0.1) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: isCurrentUser
                          ? Border.all(color: Colors.green)
                          : Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${index + 1}. ${user['name']}',
                          style: TextStyle(
                            fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                            color: isCurrentUser ? Colors.green : Colors.black,
                          ),
                        ),
                        Text(
                          '${user['points']} pts',
                          style: TextStyle(
                            fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                            color: isCurrentUser ? Colors.green : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // My Position Box (Sticky)
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Position: $myRank",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    "${leaderboard[myIndex]['points']} points",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _podiumBox({required int rank, required Map<String, dynamic>? user}) {
    Color rankColor;
    switch (rank) {
      case 1:
        rankColor = Colors.amber;
        break;
      case 2:
        rankColor = Colors.grey;
        break;
      case 3:
        rankColor = Colors.brown;
        break;
      default:
        rankColor = Colors.black;
    }

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: rankColor.withOpacity(0.2),
          child: Text(
            user != null ? '${user['name'][0]}' : '-',
            style: TextStyle(fontWeight: FontWeight.bold, color: rankColor),
          ),
        ),
        SizedBox(height: 6),
        Text(
          user != null ? user['name'] : '---',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        Text(
          user != null ? '${user['points']} pts' : '--',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          '${rank == 1 ? '🥇' : rank == 2 ? '🥈' : '🥉'}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
