import 'package:hive/hive.dart';

part 'notebook.g.dart';

@HiveType(typeId: 0)
class Notebook extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String coverColor; // hex string

  @HiveField(3)
  String coverPattern; // 'solid', 'gingham', 'dots', 'stripes', 'lace'

  @HiveField(4)
  String? character; // 'mymelody', 'none', etc.

  @HiveField(5)
  List<String> pageIds;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  Notebook({
    required this.id,
    required this.title,
    this.coverColor = '#FADADD',
    this.coverPattern = 'solid',
    this.character,
    List<String>? pageIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : pageIds = pageIds ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
