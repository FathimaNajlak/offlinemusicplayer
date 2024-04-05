import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> mostlyPlayedNotifier = ValueNotifier([]);

mostplayedadd(AllSongModel song) async {
  final Box<int> mostPlayedDB = await Hive.openBox('MostPLayed');
  int count = (mostPlayedDB.get(song.id) ?? 0) + 1;
  mostPlayedDB.put(song.id, count);
  if (count > 4 && !mostlyPlayedNotifier.value.contains(song)) {
    mostlyPlayedNotifier.value.add(song);
  }
  if (mostlyPlayedNotifier.value.length > 10) {
    mostlyPlayedNotifier.value = mostlyPlayedNotifier.value.sublist(0, 10);
  }
}
