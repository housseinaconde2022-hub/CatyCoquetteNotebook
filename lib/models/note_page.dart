import 'package:hive/hive.dart';

part 'note_page.g.dart';

@HiveType(typeId: 1)
class NotePage extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String notebookId;

  @HiveField(2)
  String content; // plain text for now, can become rich later

  @HiveField(3)
  String pageType; // 'lined', 'grid', 'dotted', 'blank', 'planner'

  @HiveField(4)
  List<String> stickers; // sticker ids placed on page

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  NotePage({
    required this.id,
    required this.notebookId,
    this.content = '',
    this.pageType = 'lined',
    List<String>? stickers,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : stickers = stickers ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
