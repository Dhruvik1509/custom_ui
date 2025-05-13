import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: DummySearchListPage());
  }
}

class DummySearchListPage extends StatefulWidget {
  const DummySearchListPage({super.key});

  @override
  State<DummySearchListPage> createState() => _DummySearchListPageState();
}

class _DummySearchListPageState extends State<DummySearchListPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grapes', 'Honeydew', 'Kiwi', 'Lemon',
    'Mango', 'Orange', 'Papaya', 'Quince', 'Raspberry',
    'Strawberry', 'Tomato', 'Ugli Fruit', 'Watermelon'
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dummy Search List")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonSearchBar(
              controller: _searchController,
              hintText: "Search fruits...",
              onChanged: _filterSearch,
              onClear: _clearSearch,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text("No results found"))
                : ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CommonSearchBar({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: const Icon(Icons.clear, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
