import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> recentlyPlayedNotifier = ValueNotifier([]);

recentadd(AllSongModel song) async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentlyPlayedNotifier.value.contains(song)) {
    recentlyPlayedNotifier.value.remove(song);
    recentlyPlayedNotifier.value.insert(0, song);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    recentlyPlayedNotifier.notifyListeners();
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id as int);
      }
    }
  } else {
    recentlyPlayedNotifier.value.insert(0, song);
    recentDb.add(song.id as int);
  }
  if (recentlyPlayedNotifier.value.length > 10) {
    recentlyPlayedNotifier.value = recentlyPlayedNotifier.value.sublist(0, 10);
    recentDb.deleteAt(0);
  }
}

getRecent() async {
  Box<int> recentDb = await Hive.openBox('recent');
  recentlyPlayedNotifier.value.clear();
  recentlyPlayedNotifier.value = allSongs
      .where((element) => recentDb.values.contains(element.id!))
      .toList();
}
