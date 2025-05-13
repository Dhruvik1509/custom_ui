import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DateFormPage());
  }
}

class DateFormPage extends StatefulWidget {
  @override
  _DateFormPageState createState() => _DateFormPageState();
}

class _DateFormPageState extends State<DateFormPage> {
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _yearController = TextEditingController();

  /// Get the date from the three fields
  DateTime? _getDateFromFields() {
    try {
      final int month = int.parse(_monthController.text);
      final int day = int.parse(_dayController.text);
      final int year = int.parse(_yearController.text);

      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  void _selectDate(BuildContext context) async {
    DateTime initialDate = _getDateFromFields() ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _monthController.text = picked.month.toString().padLeft(2, '0');
        _dayController.text = picked.day.toString().padLeft(2, '0');
        _yearController.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Format MM-DD-YYYY')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _monthController,
                    decoration: InputDecoration(
                      labelText: 'Month',
                      hintText: 'MM',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _dayController,
                    decoration: InputDecoration(
                      labelText: 'Day',
                      hintText: 'DD',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _yearController,
                    decoration: InputDecoration(
                      labelText: 'Year',
                      hintText: 'YYYY',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String month = _monthController.text;
                final String day = _dayController.text;
                final String year = _yearController.text;

                if (month.isNotEmpty && day.isNotEmpty && year.isNotEmpty) {
                  final formattedDate = '$month-$day-$year';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected Date: $formattedDate')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid date')),
                  );
                }
              },
              child: Text('Submit Date'),
            ),
          ],
        ),
      ),
    );
  }
}
