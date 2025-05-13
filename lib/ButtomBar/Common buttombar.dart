import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: BottomBarExamplePage());
  }
}

class BottomBarExamplePage extends StatefulWidget {
  const BottomBarExamplePage({super.key});

  @override
  State<BottomBarExamplePage> createState() => _BottomBarExamplePageState();
}

class _BottomBarExamplePageState extends State<BottomBarExamplePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Profile Page')),
    const Center(child: Text('Profile Page')),

  ];

  void _onBottomBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Common BottomBar Example")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CommonBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomBarTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios),label: 'Home'),
        ],
      ),
    );
  }
}

class CommonBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CommonBottomBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: ,
      // elevation: ,
      // iconSize: ,
      // selectedIconTheme: ,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      items: items,
    );
  }
}
