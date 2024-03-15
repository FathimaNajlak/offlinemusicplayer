import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:podcastapp/functions/favourite_functions.dart';

import 'nowplaying_screen.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
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
        body: ValueListenableBuilder(
          valueListenable: fav,
          builder: (context, value, child) {
            return Row(
              children: [
                Expanded(
                  child: fav.value.isEmpty
                      ? const Center(
                          child: Text('No favorite songs available'),
                        )
                      : ListView.builder(
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
                                          'assets/images/dummySong.jpg',
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                        ),
                                        id: fav.value[index].id!,
                                        type: ArtworkType.AUDIO),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        // audioConverter(fav.value, index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NowPlayingScreen(
                                                    music: fav.value[index]),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey),
                                        child: ListTile(
                                          title: Text(
                                            fav.value[index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                              fav.value[index].artist ??
                                                  'unknown',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (fav.value.contains(
                                                    fav.value[index])) {
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
                                                                      .black),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              removeFromFav(fav
                                                                  .value[index]
                                                                  .id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      'Song is removed from favorites successfully'),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              );
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
                                                } else {
                                                  addToFavorites(
                                                      fav.value[index].id!);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Song added to favorites successfully'),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ),
                                                  );
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              () {
                                                if (fav.value.contains(
                                                    fav.value[index])) {
                                                  return Icons.favorite;
                                                } else {
                                                  return Icons.favorite_border;
                                                }
                                              }(),
                                              color: () {
                                                if (fav.value.contains(
                                                    fav.value[index])) {
                                                  return Colors.red;
                                                } else {
                                                  return Colors.black;
                                                }
                                              }(),
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
                          itemCount: fav.value.length),
                ),
              ],
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:podcastapp/Screens/splash_screen.dart';
// import 'package:podcastapp/functions/favourite_functions.dart';
// import 'package:podcastapp/model/favourite_model.dart';
// import 'package:podcastapp/model/song_model.dart';
// import 'package:podcastapp/screens/nowplaying_screen.dart';

// class MyFavoritesScreen extends StatefulWidget {
//   const MyFavoritesScreen({Key? key}) : super(key: key);

//   @override
//   _MyFavoritesScreenState createState() => _MyFavoritesScreenState();
// }

// class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
//   final Box<FavoriteModel> favDB = Hive.box<FavoriteModel>('fav_DB');

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.grey,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(16),
//             ),
//           ),
//           title: const Text(
//             'My favorites',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 28,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: ValueListenableBuilder<Box<FavoriteModel>>(
//           valueListenable: favDB.listenable(),
//           builder: (context, box, child) {
//             List<FavoriteModel> favorites = box.values.toList();
//             return favorites.isEmpty
//                 ? const Center(
//                     child: Text('No favorite songs available'),
//                   )
//                 : ListView.builder(
//                     itemCount: favorites.length,
//                     itemBuilder: (context, index) {
//                       FavoriteModel favorite = favorites[index];
//                       AllSongModel song =
//                           allSongs.firstWhere((s) => s.id == favorite.id);
//                       return ListTile(
//                         leading: ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: QueryArtworkWidget(
//                             artworkClipBehavior: Clip.none,
//                             artworkHeight: 70,
//                             artworkWidth: 70,
//                             nullArtworkWidget: Image.asset(
//                               'assets/images/dummySong.jpg',
//                               fit: BoxFit.cover,
//                               width: 70,
//                               height: 70,
//                             ),
//                             id: song.id!,
//                             type: ArtworkType.AUDIO,
//                           ),
//                         ),
//                         title: Text(
//                           song.name ?? 'Unknown',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(
//                           song.artist ?? 'Unknown Artist',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         trailing: IconButton(
//                           onPressed: () {
//                             removeFromFav(song.id!);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Song removed from favorites'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           },
//                           icon: const Icon(Icons.favorite),
//                           color: Colors.red,
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   NowPlayingScreen(music: song),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//           },
//         ),
//         backgroundColor: const Color.fromARGB(255, 236, 232, 220),
//       ),
//     );
//   }
// }
