import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'todos.model.dart';

class HiveService {
  Future startHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox('todos');
  }

  Future<List<Todo>> loadAllTodos() async {
    List list = Hive.box('todos').values.toList();
    List<Todo> newList = new List<Todo>.from(list);
    print(list.runtimeType);
    print(newList.runtimeType);
    return newList;

  }
  void addTodo(Todo todo) async {
    await Hive.box('todos').add(todo);
  }

  void deleteTodo(int index) async {
    await Hive.box('todos').deleteAt(index);
  }

  void setCheckTodo(int index, Todo todo) async {
    await Hive.box('todos').putAt(index, todo);
  }
}