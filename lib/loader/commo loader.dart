import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: LoadingExamplePage()
    );
  }
}
class LoadingExamplePage extends StatelessWidget {
  const LoadingExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating loading screen
    return Scaffold(
      appBar: AppBar(title: const Text("Loading Example")),
      body: const CommonLoading(
        message: "Loading, please wait...",
        color: Colors.deepPurple,
        size: 40,
      ),
    );
  }
}


class CommonLoading extends StatelessWidget {
  final double size;
  final Color color;
  final String? message;

  const CommonLoading({
    Key? key,
    this.size = 40.0,
    this.color = Colors.blue,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 12),
            Text(
              message!,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
