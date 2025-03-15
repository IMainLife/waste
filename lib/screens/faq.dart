import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, dynamic>> faqList = [
    {
      'question': 'How can I earn Eco Points?',
      'answer': 'You can earn Eco Points by completing recycling challenges and scheduling waste pickups.'
    },
    {
      'question': 'What can I do with Eco Points?',
      'answer': 'You can redeem your Eco Points for rewards such as vouchers, discounts, or gifts.'
    },
    {
      'question': 'How do I complete challenges?',
      'answer': 'Go to the Challenges section, complete tasks, and mark them as done. Await admin approval to earn points.'
    },
    {
      'question': 'Where can I find recycling centers?',
      'answer': 'Check the map in the app or visit the Resources section for recycling center locations.'
    },
    {
      'question': 'How does the leaderboard work?',
      'answer': 'The leaderboard shows top recyclers based on total Eco Points collected.'
    },
  ];

  final TextEditingController _chatController = TextEditingController();
  String botResponse = "";

  void _handleChatQuery(String query) {
    // Placeholder logic now (upgrade later using NLP model)
    // Just echoing basic matching to simulate AI, we will replace with a real model later
    setState(() {
      botResponse = "I'm still learning to answer like an AI. But I see you're asking: \"$query\" 😊";
    });

    // 🔜 In future: Use a trained NLP model or connect to Dialogflow/ChatGPT API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ & Help'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: faqList.map((faq) {
                return ExpansionTile(
                  title: Text(faq['question']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: Text(faq['answer']),
                    )
                  ],
                );
              }).toList(),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.smart_toy_outlined, color: Colors.grey),
                SizedBox(width: 10),
                Text('Ask our AI Chatbot!'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _handleChatQuery(_chatController.text);
                    _chatController.clear();
                  },
                )
              ],
            ),
          ),
          if (botResponse.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "🤖 AI Chatbot: $botResponse",
                  style: TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
