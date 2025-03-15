import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'signin.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';
  bool isDarkMode = false;

  final List<String> languages = ['English', 'Malay', 'Chinese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          // Edit Profile
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Edit Profile Information'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          Divider(),

          // Notification Toggle
          SwitchListTile(
            title: Text("Enable Notifications"),
            subtitle: Text("Receive updates on pickups, points, challenges"),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() {
                notificationsEnabled = val;
              });
            },
            secondary: Icon(Icons.notifications_active_outlined),
          ),
          Divider(),

          // Language Setting
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: languages
                  .map((lang) => DropdownMenuItem(
                value: lang,
                child: Text(lang),
              ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedLanguage = val!;
                });
              },
            ),
          ),
          Divider(),

          // Theme Toggle
          SwitchListTile(
            title: Text("Dark Mode"),
            subtitle: Text("Switch between Light and Dark theme"),
            value: isDarkMode,
            onChanged: (val) {
              setState(() {
                isDarkMode = val;
                // TODO: Apply app-wide theme mode
              });
            },
            secondary: Icon(Icons.dark_mode_outlined),
          ),
          Divider(),

          // Contact Support
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Contact Support'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate or open support page/email
            },
          ),
          Divider(),

          // Privacy Policy
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to privacy policy screen
            },
          ),
          Divider(),

          // Terms & Conditions
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text('Terms & Conditions'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to terms screen
            },
          ),
          Divider(),

          // Logout Option
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
