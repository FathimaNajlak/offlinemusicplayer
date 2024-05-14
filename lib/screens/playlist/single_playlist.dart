import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/playlist.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/model/playlist_model.dart';
import 'package:podcastapp/screens/mini_player.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

// ignore: must_be_immutable
class SinglePlayListScreen extends StatefulWidget {
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
  State<SinglePlayListScreen> createState() => _SinglePlayListScreenState();
}

class _SinglePlayListScreenState extends State<SinglePlayListScreen> {
  @override
  Widget build(BuildContext context) {
    print(playlistnotifier.value[0].playlist?[0].id);
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
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 44, 79, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: Text(
            widget.playlistname,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showPlaylistSheet(context, widget.playlistname);
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
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
                  child: playlistnotifier.value[widget.idx].playlist?.isEmpty ??
                          true
                      ? const Center(
                          child: Text(
                            'please add some songs',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final data = playlistnotifier
                                .value[widget.idx].playlist![index];
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
                                      id: playlistnotifier.value[widget.idx]
                                          .playlist![index].id!,
                                      type: ArtworkType.AUDIO,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        final song =
                                            widget.listIndex.playlist![index];
                                        recentadd(song);
                                        mostplayedadd(song);

                                        audioConverter(
                                            widget.listIndex.playlist!, index);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                              song: widget
                                                  .listIndex.playlist![index],
                                              songId: widget.listIndex
                                                  .playlist![index].id!,
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
                                          color:
                                              Color.fromARGB(255, 60, 73, 60),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            playlistnotifier.value[widget.idx]
                                                    .playlist![index].name ??
                                                "song name",
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            playlistnotifier.value[widget.idx]
                                                    .playlist![index].artist ??
                                                'unknown',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          trailing: PopupMenuButton(
                                            icon: const Icon(Icons.more_vert,
                                                size: 20,
                                                color: Color.fromARGB(
                                                    255, 252, 249, 249)),
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                  value: 'favorites',
                                                  child:
                                                      favoriteChecking(data.id!)
                                                          ? const Text(
                                                              'Remove from favorites',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          29,
                                                                          28,
                                                                          28)),
                                                            )
                                                          : const Text(
                                                              'Add to favorites',
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          39,
                                                                          38,
                                                                          38)),
                                                            ),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'delete',
                                                  child: Text(
                                                    'Delete from playlist',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 26, 25, 25)),
                                                  ),
                                                ),
                                              ];
                                            },
                                            onSelected: (String value) {
                                              if (value == 'favorites') {
                                                print(
                                                    favoriteChecking(data.id!));
                                                if (favoriteChecking(
                                                    data.id!)) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Confirmation'),
                                                        content: const Text(
                                                            'Are you sure you want to remove the song from favorites?'),
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
                                                                      .white),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              removeFromFav(
                                                                  playlistnotifier
                                                                      .value[widget
                                                                          .idx]
                                                                      .playlist![
                                                                          index]
                                                                      .id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content:
                                                                      const Text(
                                                                    'Song is removed from favorites successfully',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
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
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  addToFavorites(
                                                      playlistnotifier
                                                          .value[widget.idx]
                                                          .playlist![index]
                                                          .id!);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: const Text(
                                                        'Song added to favorites successfully',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  );
                                                }
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
                                                                    .white),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            removeSongFromPlaylistAndNotify(
                                                                data,
                                                                widget
                                                                    .playlistname,
                                                                widget.idx);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                          itemCount: playlistnotifier
                              .value[widget.idx].playlist!.length,
                        ),
                ),
              ],
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 40, 54, 38),
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
          color: Color.fromARGB(255, 40, 54, 38),
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
                              color: Color.fromARGB(255, 60, 73, 60),
                            ),
                            child: ListTile(
                              title: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              subtitle: SizedBox(
                                height: 20,
                                child: Text(
                                  allSongs[index].artist ?? 'unknown',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
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
