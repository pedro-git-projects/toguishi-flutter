import 'package:flutter/material.dart';
import 'package:toguishi/screens/authenticated/advertise_screen.dart';
import 'package:toguishi/screens/authenticated/chat_screen.dart';
import 'package:toguishi/screens/authenticated/home_screen.dart';
import 'package:toguishi/screens/authenticated/search_screen.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _selectedTabIndex = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const ChatScreen(),
      const AdvertiseScreen(),
      const SearchScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_selectedTabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ínicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Criar Anúncio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (int index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
