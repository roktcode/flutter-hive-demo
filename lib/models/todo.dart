import "package:hive/hive.dart";

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String text;
  @HiveField(2)
  late bool isCompleted;

  Todo({required this.id, required this.text, this.isCompleted = false});
}
