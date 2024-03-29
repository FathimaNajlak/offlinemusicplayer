import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/model/favourite_model.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

List<AllSongModel> favoriteSongsList = [];
getAllSongs() async {
  var favDb = await Hive.openBox<FavoriteModel>('fav_DB');
  Box<AllSongModel> songs = await Hive.openBox<AllSongModel>('songs');
  List<FavoriteModel> favList = favDb.values.toList();
  var allList = songs.values.toList();

  for (var item in favList) {
    for (var i = 0; i < allSongs.length; i++) {
      log('${item.id.toString()} _ ${item.id.toString()}');
      if (item.id == allList[i].id) {
        favoriteSongsList.add(allList[i]);
      }
    }
  }
  log('favsongs.length${allList.length}');
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  // final fav = ValueNotifier<List<AllSongModel>>([]);
  @override
  void initState() {
    // favfetch();
    getAllSongs();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllSongs();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'My favorites',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: favoriteSongsList.isEmpty
            ? const Center(
                child: Text('No favorite songs '),
              )
            : ListView.builder(
                itemCount: favoriteSongsList.length,
                itemBuilder: (context, index) {
                  // final song = favoriteSongs[index];
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
                            id: favoriteSongsList[index].id!,
                            // id: song.id!,
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(
                                    song: favoriteSongsList[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey,
                              ),
                              child: ListTile(
                                title: Text(
                                  favoriteSongsList[index].name ?? 'Unknown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  favoriteSongsList[index].artist ??
                                      'Unknown Artist',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (favoriteSongsList
                                          .contains(favoriteSongsList[index])) {
                                        // Remove from favorites
                                        removeFromFav(
                                            favoriteSongsList[index].id!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Song removed from favorites',
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Add to favorites
                                        addToFavorites(
                                            favoriteSongsList[index].id!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Song added to favorites',
                                            ),
                                          ),
                                        );
                                      }
                                      getAllSongs();
                                    });
                                  },
                                  icon: Icon(
                                    favoriteSongsList
                                            .contains(favoriteSongsList[index])
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favoriteSongsList
                                            .contains(favoriteSongsList[index])
                                        ? Colors.red
                                        : Colors.black,
                                    size: 20,
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
              ),
        // body: ValueListenableBuilder<List<AllSongModel>>(
        //   valueListenable: fav,
        //   builder: (context, value, child) {
        //     log(fav.value.length.toString());
        //     return
        //   },
        // ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
