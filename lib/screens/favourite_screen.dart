import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/audio_converter_function.dart';
import 'package:podcastapp/functions/favourite_functions.dart';
import 'package:podcastapp/functions/mostly_played.dart';
import 'package:podcastapp/functions/recently_played.dart';
import 'package:podcastapp/screens/nowplaying_screen.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({Key? key}) : super(key: key);

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          title: const Text(
            'My favorites',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: favoriteNotifier,
          builder: (context, favoriteSongsList, child) {
            return favoriteSongsList.isEmpty
                ? Center(
                    child: Text(
                      'No favorite songs ',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: favoriteSongsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        child: Card(
                          color: Colors.grey[900],
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(4.0),
                            onTap: () {
                              recentadd(favoriteSongsList[index]);
                              mostplayedadd(favoriteSongsList[index]);
                              audioConverter(favoriteSongsList, index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(
                                    song: favoriteSongsList[index],
                                    songId: favoriteSongsList[index].id!,
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
                                id: favoriteSongsList[index].id!,
                                type: ArtworkType.AUDIO,
                              ),
                            ),
                            title: Text(
                              favoriteSongsList[index].name ?? 'Unknown',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              favoriteSongsList[index].artist ??
                                  'Unknown Artist',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (favoriteSongsList
                                      .contains(favoriteSongsList[index])) {
                                    // Remove from favorites
                                    removeFromFav(favoriteSongsList[index].id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Song removed from favorites',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Add to favorites
                                    addToFavorites(
                                        favoriteSongsList[index].id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Song added to favorites',
                                          style: TextStyle(color: Colors.white),
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
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
