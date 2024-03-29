import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/playlist.dart';
import 'package:podcastapp/model/playlist_model.dart';
import 'package:podcastapp/screens/favourite_screen.dart';
import 'package:podcastapp/screens/mini_player.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

// ignore: must_be_immutable
class SinglePlayListScreen extends StatelessWidget {
  String playlistname;
  final int idx;
  final PlayListModel listIndex;
  SinglePlayListScreen({
    super.key,
    required this.playlistname,
    required this.listIndex,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: Text(
            playlistname,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showPlaylistSheet(context, playlistname);
              },
              icon: const Icon(Icons.add),
              color: Colors.black,
              iconSize: 28,
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: playlistnotifier,
          builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                  child: playlistnotifier.value[idx].playlist?.isEmpty ?? true
                      ? const Center(
                          child: Text('please add some songs'),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final data =
                                playlistnotifier.value[idx].playlist![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
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
                                      id: playlistnotifier
                                          .value[idx].playlist![index].id!,
                                      type: ArtworkType.AUDIO,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        audioConverter(
                                            listIndex.playlist!, index);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                              song: listIndex.playlist![index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            playlistnotifier.value[idx]
                                                    .playlist![index].name ??
                                                "song name",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            playlistnotifier.value[idx]
                                                    .playlist![index].artist ??
                                                'unknown',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: PopupMenuButton(
                                            icon: const Icon(Icons.more_vert,
                                                size: 20, color: Colors.black),
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                  value: 'favorites',
                                                  child: favoriteNotifier.value
                                                          .contains(
                                                              allSongs[index])
                                                      ? const Text(
                                                          'Remove from favorites')
                                                      : const Text(
                                                          'Add to favorites'),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'delete',
                                                  child: Text(
                                                      'Delete from playlist'),
                                                ),
                                              ];
                                            },
                                            onSelected: (String value) {
                                              if (value == 'favorites') {
                                                // Code for handling the favorites option
                                              } else if (value == 'delete') {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirmation'),
                                                      content: const Text(
                                                          'Are you sure you want to remove the song from the playlist?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            removeSongFromPlaylistAndNotify(
                                                                data,
                                                                playlistname,
                                                                idx);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              playlistnotifier.value[idx].playlist!.length,
                        ),
                ),
              ],
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }
}

showPlaylistSheet(BuildContext context, String playlistname) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: const Color.fromARGB(255, 236, 232, 220),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = allSongs[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      ClipRRect(
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
                      const SizedBox(width: 6),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            addSongToPlaylistAndShowSnackbar(
                                data, playlistname, context);
                          },
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              subtitle: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].artist ?? 'unknown',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: allSongs.length,
            ),
          ),
        ),
      );
    },
  );
}
