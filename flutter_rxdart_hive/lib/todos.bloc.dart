import 'package:flutter_rxdart_hive/todos.model.dart';
import 'package:rxdart/rxdart.dart';
import 'hive.dart';
class TodosBloc {
  HiveService hive = HiveService();

  var _todos = BehaviorSubject<List<Todo>>();

  Stream<List<Todo>> get todos => _todos.stream;

  loadTodos() async {
    List<Todo> list = await hive.loadAllTodos();
    if (list != null) _todos.sink.add(list);
  }
  setCheck(bool val, int index) async {
    List<Todo> list = _todos.value;
    list[index].completed = val;
    _todos.sink.add(list);

    hive.setCheckTodo(index, list[index]);
  }

  addTodo(String value) async {

    Todo todo = new Todo(name: value, completed: false);

    List<Todo> list = _todos.value;

    if (list == null) {
      _todos.sink.add([todo]);
    } else {
      list.add(todo);
      _todos.sink.add(list);
    }

    hive.addTodo(todo);
  }
  deleteTodo(int index) async {
    List<Todo> list = _todos.value;
    list.removeAt(index);
    _todos.sink.add(list);

    hive.deleteTodo(index);
  }


  dispose() {
    _todos.close();
  }

}