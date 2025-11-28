import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  final TextEditingController _dateController = TextEditingController();
  String hintDate = "Select a date"; // Variable to hold the hint text
  DateTime? pickedDate; // Variable to store the selected date

  Future<void> _selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        hintDate = '${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date Picker Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _dateController,
                readOnly: true, // Prevent manual input
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: hintDate, // Display the selected date in the hint
                  suffixIcon: IconButton(
                    onPressed: () => _selectDate(context), // Trigger the date picker
                    icon: const Icon(Icons.calendar_month),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
