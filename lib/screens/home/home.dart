import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/screens/home/widgets/container.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/recently_played_screen.dart';
import 'package:podcastapp/screens/search_screen.dart';
import 'package:podcastapp/screens/splash_screen.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/model/add_song.dart';
import 'package:podcastapp/screens/test.dart';
import '../mostly_played_screen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final ScrollController controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenTest()),
                );
              },
              icon: const Icon(Icons.abc),
            ),
          ],
        ),
        body: Scrollbar(
          controller: controller,
          thickness: 6,
          thumbVisibility: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  containerHome(
                    context,
                    'Mostly played',
                    MostlyPlayedScreen(),
                  ),
                  containerHome(
                    context,
                    'Recently played',
                    RecentlyPlayedScreen(),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'All Audios',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: songsAddedInBox.length,
                itemBuilder: (context, index) {
                  final song = songsAddedInBox[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NowPlayingScreen()),
                      );
                    },
                    child: ListTile(
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
                          id: song.id!,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                      title: Text(song.name ?? 'name'),
                      subtitle: Text(song.artist ?? 'Unknown Artist'),
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
                              child: fav.value.contains(allSongs[index])
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
                            if (fav.value.contains(allSongs[index])) {
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          removeFromFav(allSongs[index].id!);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Song is removed from favorites successfully',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              addToFavorites(allSongs[index].id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Song added to favorites successfully',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            }
                          } else if (value == 'playlist') {}
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
