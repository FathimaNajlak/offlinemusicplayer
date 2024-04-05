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
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Mostly played',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.black,
              )),
        ),
        body: buildListOfSongs(
            valueListenable: mostlyPlayedNotifier,
            emptyString: 'please play some songs...'),
        bottomSheet: const MiniPlayer(),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
