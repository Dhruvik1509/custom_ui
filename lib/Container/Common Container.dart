import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common Container Example')),
      body: Center(
        child: CommonContainer(
          width: 200,
          height: 100,
          color: Colors.lightBlue.shade50,
          border: Border.all(color: Colors.blue),
          boxShadow: BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          child: Center(
            child: Text('This is a common container!'),
          ),
        ),
      ),
    );
  }
}


class CommonContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final double borderRadius;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final BoxShadow? boxShadow;

  const CommonContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.all(8),
    this.color = Colors.white,
    this.borderRadius = 12,
    this.border,
    this.width,
    this.height,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow != null ? [boxShadow!] : [],
      ),
      child: child,
    );
  }
}
