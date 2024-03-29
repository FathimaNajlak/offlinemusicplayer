import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<AllSongModel>> recentList = ValueNotifier([]);

recentadd(AllSongModel song) async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentDb.values);
  if (recentList.value.contains(song)) {
    recentList.value.remove(song);
    recentList.value.insert(0, song);
    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentDb.deleteAt(i);
        recentDb.add(song.id as int);
      }
    }
  } else {
    recentList.value.insert(0, song);
    recentDb.add(song.id as int);
  }
  if (recentList.value.length > 10) {
    recentList.value = recentList.value.sublist(0, 10);
    recentDb.deleteAt(0);
  }
  log(recentList.value.length.toString());
}
