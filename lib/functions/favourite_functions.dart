import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/favourite_model.dart';
import 'package:podcastapp/screens/favourite_screen.dart';

// ValueNotifier<List<AllSongModel>> fav = ValueNotifier([]);

addToFavorites(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  if (favoriteSongsList.any((element) => element.id == id)) {
    log('Song with ID $id is already in favorites.');
    return;
  }
  await favDB.put(id, FavoriteModel(id: id));
  favoriteSongsList.clear();
  for (var elements in allSongs) {
    if (elements.id == id) {
      favoriteSongsList.add(elements);
      break;
    }
  }
  log(favDB.values.length.toString());
  log("======================================================${favoriteSongsList.length.toString()}");
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.delete(id);
  // for (var element in allSongs) {
  //   if (element.id == id) {
  //     favoriteSongsList.remove(element);
  //   }
  // }
  favoriteSongsList.removeWhere((song) => song.id == id);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  // fav.notifyListeners();
}

favfetch() async {
  List<FavoriteModel> favsongcheck = [];
  Box<FavoriteModel> favdb = await Hive.openBox<FavoriteModel>('fav_DB');
  favsongcheck.addAll(favdb.values);
  log(favdb.values.length.toString());
  for (var favs in favsongcheck) {
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        favoriteSongsList.add(songs);
      }
    }
  }
}

bool favoriteChecking(int data) {
  for (var element in favoriteSongsList) {
    if (data == element.id) {
      return true;
    }
  }
  return false;
}
