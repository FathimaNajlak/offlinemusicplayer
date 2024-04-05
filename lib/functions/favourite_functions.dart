import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/favourite_model.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> favoriteNotifier = ValueNotifier([]);

addToFavorites(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  if (favoriteNotifier.value.any((element) => element.id == id)) {
    return;
  }
  await favDB.put(id, FavoriteModel(id: id));

  favfetch();
}

Future<void> removeFromFav(int id) async {
  final favDB = await Hive.openBox<FavoriteModel>('fav_DB');
  await favDB.delete(id);

  favoriteNotifier.value.removeWhere((song) => song.id == id);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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

bool favoriteChecking(int id) {
  log(id.toString());
  for (var song in favoriteNotifier.value) {
    if (id == song.id) {
      return true;
    }
  }
  return false;
}
