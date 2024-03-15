import 'package:hive/hive.dart';
part 'song_model.g.dart';

@HiveType(typeId: 1)
class AllSongModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? uri;

  AllSongModel(
      {required this.name,
      required this.artist,
      required this.duration,
      required this.id,
      required this.uri});
}
