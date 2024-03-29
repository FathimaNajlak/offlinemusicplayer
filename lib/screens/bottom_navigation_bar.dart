import 'package:flutter/material.dart';
import 'package:podcastapp/screens/favourite_screen.dart';
import 'package:podcastapp/screens/playlist/playlist_screen.dart';
import 'home/home.dart';

final ValueNotifier<int> _currentIndex = ValueNotifier(0);

class BottomNaviScreen extends StatelessWidget {
  BottomNaviScreen({super.key});

  final screen = [
    const ScreenHome(),
    const MyFavoritesScreen(),
    PlaylistScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, updatedIndex, child) {
            return screen[updatedIndex];
          },
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (BuildContext context, int updatedindex, child) {
            return BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              currentIndex: updatedindex,
              backgroundColor: Colors.grey,
              onTap: (index) {
                _currentIndex.value = index;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 28,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      size: 28,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.playlist_add,
                      size: 28,
                    ),
                    label: ''),
              ],
            );
          },
        ),
      ),
    );
  }
}
