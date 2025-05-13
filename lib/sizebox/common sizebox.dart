import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: SizedBoxExamplePage());
  }
}

class SizedBoxExamplePage extends StatelessWidget {
  const SizedBoxExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Common SizedBox Example")),
      body: Column(
        children: [
          const Text("Above space"),
          const CommonSizedBox(height: 20),
          const Text("Below space"),
          const CommonSizedBox(height: 40),
          const Row(
            children: [Text("Left"), CommonSizedBox(width: 30), Text("Right")],
          ),
        ],
      ),
    );
  }
}

class CommonSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const CommonSizedBox({Key? key, this.width, this.child, this.height})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: child, width: width, height: height);
  }
}
