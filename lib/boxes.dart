import 'package:hive/hive.dart';
import 'package:hive_demo/models/todo.dart';

class Boxes {
  static Box<Todo> getTodos() => Hive.box("todos");
}
