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
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            color: Colors.black,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              containerHome(
                context,
                'Mostly played',
                const MostlyPlayedScreen(),
                'assets/images/dummy image.jpg',
              ),
              containerHome(
                context,
                'Recently played',
                const RecentlyPlayedScreen(),
                'assets/images/sample.jpg',
              ),
            ],
          ),
          kHeight20,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'All Audios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: allSongs.length,
                    itemBuilder: (context, index) {
                      return allSongs.isEmpty
                          ? const Center(
                              child: Text('No audios found'),
                            )
                          : ListTile(
                              onTap: () {
                                audioConverter(allSongs, index);
                                recentadd(allSongs[index]);
                                mostplayedadd(allSongs[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlayingScreen(
                                      song: allSongs[index],
                                      songId: allSongs[index].id!,
                                    ),
                                  ),
                                );
                              },
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
                                  type: ArtworkType.AUDIO,
                                ),
                              ),
                              title: Text(
                                allSongs[index].name ?? 'name',
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                allSongs[index].artist ?? 'Unknown Artist',
                                maxLines: 1,
                              ),
                              trailing: PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      value: 'favorites',
                                      child: favoriteNotifier.value
                                              .contains(allSongs[index])
                                          ? const Text('Remove from favorites')
                                          : const Text('Add to favorites'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'playlist',
                                      child: Text('Add to playlist'),
                                    ),
                                  ];
                                },
                                onSelected: (String value) {
                                  if (value == 'favorites') {
                                    if (favoriteNotifier.value
                                        .contains(allSongs[index])) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Confirmation'),
                                            content: const Text(
                                                'Are you sure you want to remove the song from favorites?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  removeFromFav(
                                                      allSongs[index].id!);
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: const Text(
                                                        'Song is removed from favorites successfully',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      addToFavorites(allSongs[index].id!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Song added to favorites successfully',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    }
                                  } else if (value == 'playlist') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddToPlaylistsScreen(
                                                song: allSongs[index]),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
