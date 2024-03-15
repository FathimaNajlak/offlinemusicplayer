import 'package:hive/hive.dart';
part 'favourite_model.g.dart';

@HiveType(typeId: 2)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int? id;

  FavoriteModel({required this.id});
}
