import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common Bottom Sheet Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Common Bottom Sheet Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCommonBottomSheet(
              context,
              height: 435,
              width: 402,
              title: 'Choose an Option',
              options: ['Option 1', 'Option 2', 'Option 3'],
              onSelect: (option) {
                // Handle the selected option
                Navigator.of(context).pop(); // Close the bottom sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected: $option')),
                );
              },
            );
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

void showCommonBottomSheet(
  BuildContext context, {
  String? title,
  double? height,
  double? width,
  List<String>? options,
  required Function(String) onSelect,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: height!,
        width: width!,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...options!.map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  onSelect(option); // Call the onSelect callback
                },
              );
            }).toList(),
          ],
        ),
      );
    },
  );
}
