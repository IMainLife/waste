import 'package:flutter/material.dart';

class Challenge {
  final String title;
  final String wasteType;
  final int points;
  bool isCompleted;

  Challenge({
    required this.title,
    required this.wasteType,
    required this.points,
    this.isCompleted = false,
  });
}

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Challenge> allChallenges = [
    Challenge(title: 'Recycle 5 Plastic Bottles', wasteType: 'Plastic Waste', points: 100),
    Challenge(title: 'Donate Old Electronics', wasteType: 'Electronic Waste', points: 120),
    Challenge(title: 'Sort Paper Waste Properly', wasteType: 'Paper Waste', points: 80),
    Challenge(title: 'Clean and Recycle Glass Bottles', wasteType: 'Glass Waste', points: 90),
    Challenge(title: 'Compost Food Waste', wasteType: 'Food Waste', points: 70),
  ];

  List<Challenge> filteredChallenges = [];
  String selectedFilter = 'High to Low Points';
  String selectedWasteType = 'All';

  @override
  void initState() {
    super.initState();
    filteredChallenges = List.from(allChallenges);
    _applyFilters();
  }

  void _applyFilters() {
    List<Challenge> result = List.from(allChallenges);

    // Filter by Waste Type
    if (selectedWasteType != 'All') {
      result = result.where((c) => c.wasteType == selectedWasteType).toList();
    }

    // Sort by Points
    if (selectedFilter == 'High to Low Points') {
      result.sort((a, b) => b.points.compareTo(a.points));
    } else {
      result.sort((a, b) => a.points.compareTo(b.points));
    }

    setState(() {
      filteredChallenges = result;
    });
  }

  void _markAsDone(int index) {
    if (filteredChallenges[index].isCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You've already marked this challenge as done. Awaiting approval.")),
      );
      return;
    }

    setState(() {
      filteredChallenges[index].isCompleted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Challenge marked as done. Awaiting admin approval.")),
    );

    // TODO: Later, send this status to Firebase for admin review
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eco Challenges"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Filters Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Sort Filter
                Row(
                  children: [
                    Text("Sort by: "),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedFilter,
                      items: ['High to Low Points', 'Low to High Points']
                          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedFilter = val!;
                          _applyFilters();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Waste Type Filter
                Row(
                  children: [
                    Text("Waste type: "),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedWasteType,
                      items: ['All', 'Plastic Waste', 'Paper Waste', 'Glass Waste', 'Electronic Waste', 'Food Waste']
                          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedWasteType = val!;
                          _applyFilters();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Challenge List
          Expanded(
            child: ListView.builder(
              itemCount: filteredChallenges.length,
              itemBuilder: (context, index) {
                final challenge = filteredChallenges[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(challenge.title),
                    subtitle: Text('${challenge.wasteType} - ${challenge.points} Eco Points'),
                    trailing: challenge.isCompleted
                        ? Icon(Icons.check_circle, color: Colors.grey)
                        : ElevatedButton(
                      onPressed: () => _markAsDone(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Done"),
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
