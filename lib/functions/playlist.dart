import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:podcastapp/model/playlist_model.dart';
import 'package:podcastapp/model/song_model.dart';

ValueNotifier<List<PlayListModel>> playlistnotifier = ValueNotifier([]);
void createNewPlaylist(String name) {
  bool check = false;
  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
      check = true;
    }
  }
  if (check == false) {
    PlayListModel item = PlayListModel(playListName: name);
    addPlaylistItemToDB(item);
  }
}

//addToPlaylist
void addPlaylistItemToDB(PlayListModel item) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  playlistDB.add(item);
  retrieveAllPlaylists();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

//getPlaylist
Future<void> retrieveAllPlaylists() async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  playlistnotifier.value.clear();
  playlistnotifier.value.addAll(playlistDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void deletePlaylistByIndex(int index) async {
  String? playlistName = playlistnotifier.value[index].playListName;
  final playlistDB = await Hive.openBox<PlayListModel>('playlist');
  for (PlayListModel elements in playlistDB.values) {
    if (elements.playListName == playlistName) {
      var key = elements.key;
      playlistDB.delete(key);
    }
  }
  playlistnotifier.value.removeAt(index);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

Future<void> renamePlaylistByIndex(int index, String newname) async {
  String? playListname = playlistnotifier.value[index].playListName;
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  for (PlayListModel element in playListDB.values) {
    if (element.playListName == playListname) {
      var key = element.key;
      element.playListName = newname;
      playListDB.put(key, element);
    }
  }
  playlistnotifier.value[index].playListName = newname;
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void addSongToPlaylistAndShowSnackbar(
    AllSongModel song, String name, BuildContext context) {
  // ignore: unused_local_variable
  int indx = 0;
  bool check = false;
  List<AllSongModel> forThisPlayList = [];

  for (var element in playlistnotifier.value) {
    if (element.playListName == name) {
      forThisPlayList = element.playlist ?? forThisPlayList;
      break;
    }
    indx++;
  }

  for (var element in forThisPlayList) {
    if (element.id == song.id) {
      check = true;
      break;
    }
  }

  if (check == false) {
    forThisPlayList.add(song);
    PlayListModel thisPlaylist =
        PlayListModel(playListName: name, playlist: forThisPlayList);
    addPlaylistToDB(thisPlaylist);

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Song added to playlist successfully',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  } else {
    // Show error snackbar if song already exists in the playlist
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'This song is already added to the playlist',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context);
  }
}

void addPlaylistToDB(PlayListModel playListItem) async {
  final playListDB = await Hive.openBox<PlayListModel>('PlayList');
  int index = 0;
  for (var element in playListDB.values) {
    if (element.playListName == playListItem.playListName) {
      break;
    }
    index++;
  }
  playListDB.putAt(index, playListItem);
  retrieveAllPlaylists();
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  playlistnotifier.notifyListeners();
}

void removeSongFromPlaylistAndNotify(
    AllSongModel song, String playlisname, int index) async {
  final playlistDB = await Hive.openBox<PlayListModel>('PlayList');
  List<AllSongModel> newlist;

  for (var element in playlistDB.values) {
    if (element.playListName == playlisname) {
      for (var elements in element.playlist!) {
        if (song.id == elements.id) {
          element.playlist!.remove(elements);
          newlist = element.playlist!;
          final newplaylist =
              PlayListModel(playListName: playlisname, playlist: newlist);
          playlistDB.putAt(index, newplaylist);
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          playlistnotifier.notifyListeners();
          break;
        }
      }
    }
  }
}
