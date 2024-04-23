import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:podcastapp/screens/mini_player.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/playlist/add_to_playlist.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

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
            'Recently Played',
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
            ),
          ),
        ),
        body: buildListOfSongs(
          valueListenable: recentlyPlayedNotifier,
          emptyString: 'please play some songs...',
        ),
        bottomSheet: const MiniPlayer(),
        backgroundColor: Color.fromARGB(255, 40, 54, 38),
      ),
    );
  }
}

Row buildListOfSongs({
  required ValueListenable<List<AllSongModel>> valueListenable,
  required String emptyString,
}) {
  return Row(
    children: [
      Expanded(
        child: ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, value, child) {
            if (valueListenable.value.isEmpty) {
              return Center(
                child: Text(
                  emptyString,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Color.fromARGB(255, 60, 73, 60),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(4.0),
                        onTap: () {
                          recentadd(valueListenable.value[index]);
                          mostplayedadd(valueListenable.value[index]);
                          audioConverter(valueListenable.value, index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlayingScreen(
                                song: valueListenable.value[index],
                                songId: valueListenable.value[index].id!,
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
                            id: valueListenable.value[index].id!,
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                        title: Text(
                          valueListenable.value[index].name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          valueListenable.value[index].artist ?? 'unknown',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton(
                          icon: const Icon(
                            Icons.more_vert,
                            size: 20,
                            color: Colors.white,
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: 'favorites',
                                child: favoriteNotifier.value.contains(
                                  valueListenable.value[index],
                                )
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
                              if (favoriteNotifier.value.contains(
                                valueListenable.value[index],
                              )) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                        'Are you sure you want to remove the song from favorites?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            removeFromFav(valueListenable
                                                .value[index].id!);
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Song is removed from favorites successfully',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                addToFavorites(
                                    valueListenable.value[index].id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Song added to favorites successfully',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              }
                            } else if (value == 'playlist') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddToPlaylistsScreen(
                                    song: valueListenable.value[index],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: valueListenable.value.length,
              );
            }
          },
        ),
      ),
    ],
  );
}
