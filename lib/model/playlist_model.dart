import 'package:hive_flutter/adapters.dart';
import 'package:podcastapp/model/song_model.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 3)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String? playListName;
  @HiveField(1)
  List<AllSongModel>? playlist = [];
  PlayListModel({required this.playListName, this.playlist});
}
