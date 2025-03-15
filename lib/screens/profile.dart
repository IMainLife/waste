import 'package:flutter/material.dart';
import 'editprofile.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'EcoTrack',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/icons/user.png'),
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: 10),

            // Name & Email
            Text(
              'hello',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'police@gmail.com',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 30),

            // Profile Options
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Edit profile information'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.notifications_outlined),
              title: Text('Notifications'),
              trailing: Text(
                'On',
                style: TextStyle(color: Colors.grey[600]),
              ),
              onTap: () {
                // TODO: Notification settings
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Text(
                'English',
                style: TextStyle(color: Colors.grey[600]),
              ),
              onTap: () {
                // TODO: Language settings
              },
            ),
            Divider(),

            // Security Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Security',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Theme'),
              trailing: Text(
                'Light mode',
                style: TextStyle(color: Colors.grey[600]),
              ),
              onTap: () {
                // TODO: Theme settings
              },
            ),
            Divider(),

            // Help & Support
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Help & Support',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Contact us'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Contact page
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy policy'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }
}
