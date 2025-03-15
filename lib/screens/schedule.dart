import 'package:flutter/material.dart';
import 'pickup_history.dart'; // Import the Pickup History screen

class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedWasteType;

  final List<String> wasteTypes = [
    'Plastic Waste',
    'Food Waste',
    'Paper Waste',
    'Glass Waste',
    'Electronic Waste',
    'Other',
  ];

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _confirmPickup() {
    if (selectedDate != null && selectedTime != null && selectedWasteType != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Pickup scheduled on ${selectedDate!.toLocal().toString().split(' ')[0]} at ${selectedTime!.format(context)} for $selectedWasteType."),
        ),
      );
      // TODO: Later connect this to Firebase database or send notification
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please complete all fields."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Waste Pickup"),
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select a date for waste collection:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: Icon(Icons.calendar_today),
              label: Text(selectedDate != null
                  ? "${selectedDate!.toLocal().toString().split(' ')[0]}"
                  : "Pick Date"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
                elevation: 0,
              ),
            ),
            SizedBox(height: 20),

            Text("Select a time for pickup:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickTime,
              icon: Icon(Icons.access_time),
              label: Text(selectedTime != null
                  ? selectedTime!.format(context)
                  : "Pick Time"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
                elevation: 0,
              ),
            ),
            SizedBox(height: 20),

            Text("Select waste type:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedWasteType,
                hint: Text("Choose waste type"),
                underline: SizedBox(),
                items: wasteTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWasteType = value;
                  });
                },
              ),
            ),
            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _confirmPickup,
                child: Text("Confirm Pickup"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PickupHistoryScreen()),
                  );
                },
                icon: Icon(Icons.history),
                label: Text("Pickup History"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
