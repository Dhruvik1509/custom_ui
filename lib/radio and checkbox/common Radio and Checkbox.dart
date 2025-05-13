import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Common_radio_and_checkbox()
    );
  }
}

class Common_radio_and_checkbox extends StatelessWidget {
  const Common_radio_and_checkbox({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonWidgetsExample();
  }
}


class CommonWidgetsExample extends StatefulWidget {
  @override
  _CommonWidgetsExampleState createState() => _CommonWidgetsExampleState();
}

class _CommonWidgetsExampleState extends State<CommonWidgetsExample> {
  String selectedGender = 'Male';
  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Common Radio & Checkbox")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select Gender:", style: TextStyle(fontWeight: FontWeight.bold)),
            CommonRadioButton<String>(
              activeColor: Colors.red,
              value: 'Male',
              groupValue: selectedGender,
              label: 'Male',
              onChanged: (val) => setState(() => selectedGender = val!),
            ),
            CommonRadioButton<String>(
              activeColor: Colors.red,
              value: 'Female',
              groupValue: selectedGender,
              label: 'Female',
              onChanged: (val) => setState(() => selectedGender = val!),
            ),
            SizedBox(height: 20),
            CommonCheckbox(
              value: agreeTerms,
              label: "I agree to the terms and conditions",
              onChanged: (val) => setState(() => agreeTerms = val!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (agreeTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Submitted: $selectedGender")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please agree to terms")),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}



class CommonRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Color? activeColor;
  final String label;
  final ValueChanged<T?> onChanged;

  const CommonRadioButton({
    Key? key,
    required this.value,
    this.activeColor,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio<T>(

        activeColor: activeColor,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      title: Text(label),
      onTap: () => onChanged(value),
    );
  }
}


class CommonCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;

  const CommonCheckbox({
    Key? key,
    required this.value,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
