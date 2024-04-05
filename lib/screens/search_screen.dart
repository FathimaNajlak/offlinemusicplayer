import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';
import 'package:podcastapp/screens/playlist/add_to_playlist.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<AllSongModel> searchList = [];

  @override
  void initState() {
    // TODO: implement initState
    searchList = allSongs;
    setState(() {});
    super.initState();
  }

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
            'Search',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        searchList = allSongs;
                        return;
                      }
                      searchList = allSongs
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: searchList.isEmpty
                  ? const Center(
                      child: Text('No results found'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        final song = searchList.elementAt(index);
                        return ListTile(
                          onTap: () {
                            audioConverter(searchList, index);

                            recentadd(searchList[index]);

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
                          title: Text(
                            song.name ?? 'name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            song.artist ?? 'Unknown Artist',
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
                                          .contains(searchList[index])
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
                                    .contains(searchList[index])) {
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
                                                  searchList[index].id!);
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
                                                        BorderRadius.circular(
                                                            8),
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
                                  addToFavorites(searchList[index].id!);
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
                              } else if (value == 'playlist') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddToPlaylistsScreen(
                                        song: searchList[index]),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}
