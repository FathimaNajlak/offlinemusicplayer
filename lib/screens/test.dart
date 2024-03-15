import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/model/add_song.dart';
import 'package:podcastapp/screens/home/widgets/container.dart';
import 'package:podcastapp/screens/mostly_played_screen.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/recently_played_screen.dart';
import 'package:podcastapp/screens/search_screen.dart';

class ScreenTest extends StatefulWidget {
  const ScreenTest({super.key});

  @override
  State<ScreenTest> createState() => _ScreenTestState();
}

class _ScreenTestState extends State<ScreenTest> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'Echopods',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const SettingsScreen()),
                // );
              },
              icon: const Icon(Icons.settings_rounded),
            ),
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            return allSongs.isEmpty
                ? Center(
                    child: Text('empty==${allSongs.length}'),
                  )
                : ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: QueryArtworkWidget(
                          artworkClipBehavior: Clip.none,
                          artworkHeight: 70,
                          artworkWidth: 70,
                          nullArtworkWidget: Image.asset(
                            'assets/images/mostlyplayed.jpg',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          id: allSongs[index].id!,
                          type: ArtworkType.AUDIO),
                    ),
                    title: Text(allSongs[index].name ?? 'name'),
                  );
          },
        ));
  }
}
