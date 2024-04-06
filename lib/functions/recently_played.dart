// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> recentlyPlayedNotifier = ValueNotifier([]);

void recentadd(AllSongModel song) async {
  final Box<int> recentDb = await Hive.openBox('recent');

  // Remove the song if it already exists to avoid duplicates
  final existingKey = recentDb.keys.firstWhere(
    (k) => recentDb.get(k) == song.id,
    orElse: () => null,
  );
  if (existingKey != null) {
    await recentDb.delete(existingKey);
    recentlyPlayedNotifier.value.removeWhere((s) => s.id == song.id);
  }
  await recentDb.add(song.id!);

  // Insert the new song at the beginning of the notifier list
  recentlyPlayedNotifier.value.insert(0, song);

  // Notify listeners to update the UI
  // ignore: invalid_use_of_visible_for_testing_member
  recentlyPlayedNotifier.notifyListeners();

  // Ensure the list doesn't exceed 10 songs
  if (recentlyPlayedNotifier.value.length > 10) {
    // Remove the last song from the list
    recentlyPlayedNotifier.value.removeLast();
    // Delete the corresponding entry from the Hive box
    await recentDb.deleteAt(recentDb.length - 1);
  }
}

ValueNotifier<List<AllSongModel>> recent = ValueNotifier([]);

getRecent() async {
  Box<int> recentDb = await Hive.openBox('recent');
  recent.value.clear();
  recent.value = allSongs
      .where((element) => recentDb.values.contains(element.id!))
      .toList();
}
