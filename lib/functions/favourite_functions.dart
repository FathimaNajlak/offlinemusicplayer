import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/model/favourite_model.dart';
import 'package:podcastapp/model/song_model.dart';
import '../screens/splash_screen.dart';

ValueNotifier<List<AllSongModel>> fav = ValueNotifier([]);

// addToFavorites(int id) async {
//   final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
//   await favDB.put(id, FavoriteModel(id: id));
//   for (var elements in allSongs) {
//     if (elements.id == id) {
//       fav.value.add(elements);
//     }
//   }
// }
addToFavorites(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  print('abdfhwertyukqwert');
  // Check if the song is already in favorites before adding
  if (!fav.value.any((element) => element.id == id)) {
    await favDB.put(id, FavoriteModel(id: id));
    fav.value.add(allSongs.firstWhere((element) => element.id == id));
  } else {
    // Show a message like "Song already in favorites" if needed
  }

  fav.notifyListeners();
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.delete(id);
  for (var element in allSongs) {
    if (element.id == id) {
      fav.value.remove(element);
    }
  }

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  fav.notifyListeners();
}

favfetch() async {
  List<FavoriteModel> favsongcheck = [];
  Box<FavoriteModel> favdb = await Hive.openBox('fav_DB');
  favsongcheck.addAll(favdb.values);
  for (var favs in favsongcheck) {
    int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        fav.value.insert(0, songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allSongs.length) {
      var key = favs.key;
      favdb.delete(key);
    }
  }
}

bool favoriteChecking(int data) {
  for (var element in fav.value) {
    if (data == element.id) {
      return true;
    }
  }
  return false;
}
