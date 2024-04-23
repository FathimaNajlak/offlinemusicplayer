import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/screens/home/widgets/container.dart';
import 'package:podcastapp/screens/mini_player.dart';
import 'package:podcastapp/screens/mostly_played_screen.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/playlist/add_to_playlist.dart';
import 'package:podcastapp/screens/recently_played_screen.dart';
import 'package:podcastapp/screens/search_screen.dart';
import 'package:podcastapp/screens/settings/settings_screen.dart';
import 'package:podcastapp/utils/constants.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 54, 38),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 44, 79, 48),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'TuneTastic',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonHome(context, 'Mostly Played', const MostlyPlayedScreen(),
                    Color.fromARGB(255, 105, 130, 106)),
                buttonHome(
                    context,
                    'Recently Played',
                    const RecentlyPlayedScreen(),
                    Color.fromARGB(255, 105, 130, 106)),
              ],
            ),
            kHeight20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'All Audios',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: allSongs.length,
                padding: const EdgeInsets.only(bottom: 65),
                itemBuilder: (context, index) {
                  final song = allSongs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: Color.fromARGB(255, 60, 73, 60),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        onTap: () {
                          audioConverter(allSongs, index);
                          recentadd(song);
                          mostplayedadd(song);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreen(
                                song: song,
                                songId: song.id!,
                              ),
                            ),
                          );
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: QueryArtworkWidget(
                            artworkClipBehavior: Clip.none,
                            artworkHeight: 56,
                            artworkWidth: 56,
                            nullArtworkWidget: Image.asset(
                              'assets/images/mostlyplayed.jpg',
                              fit: BoxFit.cover,
                              width: 56,
                              height: 56,
                            ),
                            id: allSongs[index].id!,
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                        title: Text(
                          song.name ?? 'Unknown Title',
                          style: const TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          song.artist ?? 'Unknown Artist',
                          style: const TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle adding/removing from favorites
                                if (favoriteNotifier.value.contains(song)) {
                                  removeFromFav(song.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Removed from favorites',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  addToFavorites(song.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Added to favorites',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                favoriteNotifier.value.contains(song)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteNotifier.value.contains(song)
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle adding to playlist
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddToPlaylistsScreen(song: song),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.playlist_add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
