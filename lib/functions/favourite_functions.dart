import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/favourite_model.dart';
import 'package:podcastapp/model/song_model.dart';
import 'package:podcastapp/screens/favourite_screen.dart';

ValueNotifier<List<AllSongModel>> favoriteNotifier = ValueNotifier([]);

addToFavorites(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  if (favoriteNotifier.value.any((element) => element.id == id)) {
    log('Song with ID $id is already in favorites.');
    return;
  }
  await favDB.put(id, FavoriteModel(id: id));
  // for (var elements in allSongs) {
  //   if (elements.id == id) {
  //     favoriteNotifier.value.add(elements);
  //     break;
  //   }
  // }
  favfetch();
  log(favDB.values.length.toString());
  log("======================================================${favoriteNotifier.value.length.toString()}");
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.delete(id);
  // for (var element in allSongs) {
  //   if (element.id == id) {
  //     favoriteNotifier.value.remove(element);
  //   }
  // }
  favoriteNotifier.value.removeWhere((song) => song.id == id);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  // fav.notifyListeners();
}

favfetch() async {
  List<int> favoriteSongIds = [];
  Box<FavoriteModel> favdb = await Hive.openBox<FavoriteModel>('fav_DB');
  favoriteSongIds.addAll(favdb.values.map((e) => e.id!).toList());
  List<AllSongModel> favoriteSongsList = allSongs.where((song) {
    return favoriteSongIds.contains(song.id);
  }).toList();
  favoriteNotifier.value.clear();
  favoriteNotifier.value = favoriteSongsList;
}

bool favoriteChecking(int data) {
  for (var element in favoriteNotifier.value) {
    if (data == element.id) {
      return true;
    }
  }
  return false;
}
