import 'package:flutter/material.dart';
import 'package:toguishi/screens/authenticated/advertisement/advertise_screen.dart';
import 'package:toguishi/screens/authenticated/chat/chat_screen.dart';
import 'package:toguishi/screens/authenticated/home/home_screen.dart';
import 'package:toguishi/screens/authenticated/search/job_search_screen.dart';
import 'package:toguishi/screens/authenticated/search/search_screen.dart';

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
      const JobSearchScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color scaffoldBackgroundColor = theme.brightness == Brightness.light
        ? theme.primaryColor
        : theme.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Job',
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
