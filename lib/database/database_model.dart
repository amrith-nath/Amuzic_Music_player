import 'package:hive/hive.dart';
part 'database_model.g.dart';

@HiveType(typeId: 0)
class LocalStorageSongs extends HiveObject {
  LocalStorageSongs({
    required this.title,
    required this.artist,
    required this.uri,
    required this.duration,
    required this.id,
  });

  @HiveField(0)
  String? title;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  String? uri;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  int? id;
}
