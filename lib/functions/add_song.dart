import 'package:hive/hive.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/song_model.dart';

List<AllSongModel> songsAddedInBox = [];
Future<void> addAllSongs() async {
  Box<AllSongModel> songs = await Hive.openBox('songs');
  for (var element in allSongs) {
    await songs.add(element);
  }
  songsAddedInBox = songs.values.toList();
}
