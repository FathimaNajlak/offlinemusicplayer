import 'package:flutter/material.dart';
import 'package:podcastapp/screens/favourite_screen.dart';
import 'package:podcastapp/screens/playlist/playlist_screen.dart';
import 'home/home.dart';

final ValueNotifier<int> _currentIndex = ValueNotifier(0);

class BottomNaviScreen extends StatelessWidget {
  BottomNaviScreen({super.key});

  final List<Widget> screens = [
    const ScreenHome(),
    const MyFavoritesScreen(),
    const PlaylistScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 5, 0),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, updatedIndex, child) {
            return screens[updatedIndex];
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
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.black,
              onTap: (index) {
                _currentIndex.value = index;
              },
              currentIndex: updatedindex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 28,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_add,
                    size: 28,
                  ),
                  label: '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
