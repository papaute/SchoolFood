import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  
import 'screens/profile_screen.dart'; 
import 'screens/diary_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchoolFood',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  static const double _navBarHeight = 60.0;
  static const double _navBarMargin = 16.0;
  static const double _iconSize = 32.0;
  static const double _iconPadding = 8.0;

  int _selectedIndex = 1;  

  
  final List<Widget> _screens = const [
    HomeScreen(),
    DiaryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: _navBarHeight + _navBarMargin * 2,
      margin: const EdgeInsets.all(_navBarMargin),
      child: Stack(
        children: [
       
          Image.asset(
            'assets/images/bar.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('assets/icons/dish.png', 0),
                _buildNavButton('assets/icons/spoon.png', 1),
                _buildNavButton('assets/icons/profile.png', 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String iconPath, int index) {
    final isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: _iconSize + _iconPadding * 2,
        height: _iconSize + _iconPadding * 2,
        padding: const EdgeInsets.all(_iconPadding),
        decoration: isSelected ? BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade400,
              Colors.green.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ) : null,
        child: Image.asset(
          iconPath,
          width: _iconSize,
          height: _iconSize,
          color: isSelected ? Colors.white : Colors.green.shade100,
        ),
      ),
    );
  }
}

