import 'package:flutter/material.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/screens/mini_player.dart';
import 'package:podcastapp/screens/recently_played_screen.dart';

class MostlyPlayedScreen extends StatelessWidget {
  const MostlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 44, 79, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Mostly played',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.white,
              )),
        ),
        body: buildListOfSongs(
            valueListenable: mostlyPlayedNotifier,
            emptyString: 'please play some songs...'),
        bottomSheet: const MiniPlayer(),
        backgroundColor: Color.fromARGB(255, 40, 54, 38),
      ),
    );
  }
}
