import 'package:flutter/material.dart';
import 'package:flutterchat_app/utils/colors.dart'; 
import 'package:flutterchat_app/screens/chat_list_screen.dart'; 
import 'package:flutterchat_app/screens/status_screen.dart'; 
import 'package:flutterchat_app/screens/calls_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    ChatListScreen(),
    StatusScreen(),
    CallsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            activeIcon: Icon(Icons.circle),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            activeIcon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.message),
            )
          : null,
    );
  }
}