import 'package:hive/hive.dart';

part 'data_model.g.dart';

//dart run build_runner build

@HiveType(typeId: 0)
class Note {
  Note({
    required this.noteTitle,
    required this.noteContent,
    required this.noteCreatedAt,
    this.noteModifiedAt,
    required this.isLiked,
    required this.isDeleted,
  });
  @HiveField(0)
  String noteTitle;
  @HiveField(1)
  String noteContent;
  @HiveField(2)
  DateTime noteCreatedAt;
  @HiveField(3)
  DateTime? noteModifiedAt;
  @HiveField(4)
  bool isLiked = false;
  @HiveField(5)
  bool isDeleted = false;
}
