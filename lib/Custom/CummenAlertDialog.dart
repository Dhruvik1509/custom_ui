import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common Alert Dialog Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Common Alert Dialog Example')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showCommonAlertDialog(
                  context,
                  title: 'End live with nia demeron.',
                  message: 'Are you sure you want to End this live ?',
                  onConfirm: () {
                    // Handle confirm action
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  onCancel: () {
                    // Handle cancel action
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  height: 162,
                  width: 349,
                );
              },
              child: Text('Show Alert Dialog'),
            ),
            RoundedRectengalButton(
              tital: 'Live With Nia Rudiger',
              onpress: () {
                print('Common');
              },
              height: 49,
              width: 362,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            SmoulRectengalButton(
              tital: 'invite',
              onpress: () {},
              color: Colors.blue,
              height: 23,
              width: 66,
            ),
          ],
        ),
      ),
    );
  }
}

void showCommonAlertDialog(
  BuildContext context, {
  String? title,
  String? message,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  double? height,
  double? width,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        child: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title! ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(message! ?? '', style: TextStyle(fontSize: 18)),
                  ],
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onConfirm,
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xfff24BDC7),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onCancel,
                        child: Text(
                          'No',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class RoundedRectengalButton extends StatelessWidget {
  final String tital;
  final VoidCallback onpress;
  final double? height;
  final double? width;
  final Color? color;

  const RoundedRectengalButton({
    super.key,
    required this.tital,
    required this.onpress,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(child: Text(tital)),
      ),
    );
  }
}

class SmoulRectengalButton extends StatelessWidget {
  final String tital;
  final VoidCallback onpress;
  final double? height;
  final double? width;
  final Color? color;

  const SmoulRectengalButton({
    super.key,
    required this.tital,
    required this.onpress,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(tital)),
      ),
    );
  }
}
