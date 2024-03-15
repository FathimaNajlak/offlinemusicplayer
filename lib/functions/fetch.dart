import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:podcastapp/Screens/splash_screen.dart';
import 'package:podcastapp/model/add_song.dart';
import 'package:podcastapp/model/song_model.dart';

final OnAudioQuery audioquerry = OnAudioQuery();

requestPermission() async {
  PermissionStatus status = await Permission.storage.request();
  if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}

songfetch() async {
  bool status = await requestPermission();
  if (status) {
    Box<AllSongModel> songs = await Hive.openBox('songs');
    songs.clear();
    List<SongModel> fetchsongs = await audioquerry.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL);
    for (SongModel element in fetchsongs) {
      if (element.fileExtension == "mp3") {
        allSongs.add(AllSongModel(
            name: element.displayNameWOExt,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            uri: element.uri));
      }
    }
  }
  await addAllSongs();
}
