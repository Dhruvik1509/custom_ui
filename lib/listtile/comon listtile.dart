import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: CommonListTileExample());
  }
}

class CommonListTileExample extends StatelessWidget {
  const CommonListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Common ListTile Example")),
      body: ListView(
        children: [
          CommonListTile(
            title: "Profile",
            subtitle: "Edit your profile",
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile tapped")),
              );
            },
          ),
          CommonListTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            trailing: Switch(value: false, onChanged: (_) {}),
          ),
        ],
      ),
    );
  }
}


class CommonListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;
  final EdgeInsetsGeometry? contentPadding;

  const CommonListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.tileColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
