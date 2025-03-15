import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickWasteScreen extends StatefulWidget {
  const PickWasteScreen({Key? key}) : super(key: key);

  @override
  State<PickWasteScreen> createState() => _PickWasteScreenState();
}

class _PickWasteScreenState extends State<PickWasteScreen> {
  String selectedWasteType = '';
  File? imageFile;
  final TextEditingController noteController = TextEditingController();

  final List<String> wasteTypes = [
    'Plastic Waste',
    'Paper Waste',
    'Glass Waste',
    'Electronic Waste',
    'Food Waste',
    'Metal Waste',
  ];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void handleSubmit() {
    if (selectedWasteType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a waste type.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Waste submitted successfully!")),
    );

    // TODO: Integrate with Firebase later
    // Save waste type, note, image, timestamp, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Waste"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Waste Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedWasteType.isEmpty ? null : selectedWasteType,
              items: wasteTypes
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedWasteType = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Choose Waste Type",
              ),
            ),
            SizedBox(height: 20),
            Text("Upload Waste Photo (Optional)", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            imageFile != null
                ? Image.file(imageFile!, height: 150)
                : Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: Icon(Icons.image_outlined, size: 50),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.upload_file),
              label: Text("Choose Image"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 20),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Add Notes (e.g., 3kg plastic bottles)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
