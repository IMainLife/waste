import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedCategory = 'All';

  final List<Map<String, String>> notifications = [
    {
      'title': 'Pickup Reminder',
      'message': 'Your plastic waste pickup is scheduled tomorrow at 10:00 AM.',
      'time': '1 hour ago',
      'category': 'Pickup',
    },
    {
      'title': 'New Challenge Added!',
      'message': 'Complete "Recycle 10 Plastic Items" and earn 150 Eco Points!',
      'time': '3 hours ago',
      'category': 'Challenges',
    },
    {
      'title': 'Eco Points Earned',
      'message': 'You’ve earned 120 points for completing a challenge.',
      'time': 'Yesterday',
      'category': 'Challenges',
    },
    {
      'title': 'Level Up!',
      'message': 'Congratulations! You’ve reached Level 3 - Eco Champion 🌍',
      'time': '2 days ago',
      'category': 'System Updates',
    },
    {
      'title': 'Reward Redemption Update',
      'message': 'Your Watsons voucher has been approved. Check My Rewards.',
      'time': '3 days ago',
      'category': 'Rewards',
    },
    {
      'title': 'Missed Pickup Alert',
      'message': 'Your food waste pickup today was missed. Please reschedule.',
      'time': 'Today',
      'category': 'Pickup',
    },
  ];

  List<String> categories = [
    'All',
    'Pickup',
    'Challenges',
    'Rewards',
    'System Updates',
  ];

  @override
  Widget build(BuildContext context) {
    // Filtered list based on selected category
    List<Map<String, String>> filteredNotifications = selectedCategory == 'All'
        ? notifications
        : notifications.where((n) => n['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.grey.shade300,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(child: Text("No notifications in this category."))
                : ListView.builder(
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notif = filteredNotifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text(notif['title'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notif['message'] ?? ''),
                        SizedBox(height: 4),
                        Text(
                          notif['time'] ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    isThreeLine: true,
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
