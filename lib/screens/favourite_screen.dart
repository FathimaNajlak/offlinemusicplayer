import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

getAllSongs() async {
  favfetch();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  @override
  void initState() {
    super.initState();
    getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
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
        body: Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: favoriteNotifier,
                  builder: (context, favoriteSongsList, child) {
                    return favoriteSongsList.isEmpty
                        ? const Center(
                            child: Text('No favorite songs '),
                          )
                        : ListView.builder(
                            itemCount: favoriteSongsList.length,
                            itemBuilder: (context, index) {
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
                                        type: ArtworkType.AUDIO,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          recentadd(
                                              favoriteNotifier.value[index]);
                                          mostplayedadd(
                                              favoriteNotifier.value[index]);
                                          audioConverter(
                                              favoriteNotifier.value, index);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NowPlayingScreen(
                                                song: favoriteSongsList[index],
                                                songId: favoriteSongsList[index]
                                                    .id!,
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
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              favoriteSongsList[index].name ??
                                                  'Unknown',
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
                                                      .contains(
                                                          favoriteSongsList[
                                                              index])) {
                                                    // Remove from favorites
                                                    removeFromFav(
                                                        favoriteSongsList[index]
                                                            .id!);
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                        favoriteSongsList[index]
                                                            .id!);
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                favoriteSongsList.contains(
                                                        favoriteSongsList[
                                                            index])
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color:
                                                    favoriteSongsList.contains(
                                                            favoriteSongsList[
                                                                index])
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
                          );
                  }),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
