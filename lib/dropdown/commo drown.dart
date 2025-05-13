import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home:DropdownExamplePage()
    );
  }
}

class DropdownExamplePage extends StatefulWidget {
  @override
  _DropdownExamplePageState createState() => _DropdownExamplePageState();
}

class _DropdownExamplePageState extends State<DropdownExamplePage> {
  String? selectedCity;

  final List<String> cities = ['New York', 'London', 'Tokyo', 'Paris'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Common Dropdown Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonDropdown<String>(
          items: cities,
          value: selectedCity,
          getLabel: (city) => city,
          hintText: "Select a city",
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
        ),
      ),
    );
  }
}



class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String Function(T) getLabel;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final double? width;

  const CommonDropdown({
    Key? key,
    required this.items,
    required this.getLabel,
    required this.onChanged,
    this.value,
    this.hintText = 'Select an option',
    this.borderRadius = 12,
    this.borderColor = Colors.grey,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hintText),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(getLabel(item)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
