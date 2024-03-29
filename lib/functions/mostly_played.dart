import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> mostPlayedList = ValueNotifier([]);

mostplayedadd(AllSongModel song) async {
  final Box<int> mostPlayedDB = await Hive.openBox('MostPLayed');
  int count = (mostPlayedDB.get(song.id) ?? 0) + 1;
  mostPlayedDB.put(song.id, count);
  if (count > 4 && !mostPlayedList.value.contains(song)) {
    mostPlayedList.value.add(song);
  }
  if (mostPlayedList.value.length > 10) {
    mostPlayedList.value = mostPlayedList.value.sublist(0, 10);
  }
}
