import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: CardExamplePage()
    );
  }
}


class CardExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Common Card Example")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CommonCard(
            onTap: () => print("Card Tapped"),
            borderRadius: 16,
            color: Colors.blue.shade50,
            elevation: 4,
            child: Row(
              children: [
                Icon(Icons.info, size: 40, color: Colors.blue),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("This is a reusable card component."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CommonCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const CommonCard({
    Key? key,
    required this.child,
    this.elevation = 2.0,
    this.color = Colors.white,
    this.borderRadius = 12.0,
    this.padding,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Material(
      color: color,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );

    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: onTap != null
          ? InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      )
          : card,
    );
  }
}
