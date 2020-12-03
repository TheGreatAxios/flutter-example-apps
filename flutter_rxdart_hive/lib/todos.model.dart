import 'package:hive/hive.dart';

part 'todos.model.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool completed;

  Todo({
    this.name,
    this.completed
  });
}