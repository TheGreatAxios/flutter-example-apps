import 'package:flutter/material.dart';
import 'package:flutter_rxdart_hive/create.dialog.dart';
import 'todos.bloc.dart';
import 'todos.model.dart';

class Todos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodosState();
}

class TodosState extends State<Todos> {
  TodosBloc bloc = TodosBloc();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.loadTodos();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    if (_textEditingController.text != null) _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // Container(
            //     height: MediaQuery.of(context).size.height * .15,
            //     width: MediaQuery.of(context).size.width,
            //     padding: const EdgeInsets.all(16),
            //     child: ListView(
            //       shrinkWrap: true,
            //       children: <Widget>[
            //         Text('Add Todo',
            //             style: TextStyle(
            //               color: Colors.purple,
            //               fontSize: 24,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           textAlign: TextAlign.center,
            //         ),
            //         TextField(
            //           controller: _textEditingController,
            //           decoration: InputDecoration(
            //             hintText: 'Put Todo Here',
            //             contentPadding: const EdgeInsets.only(left: 16),
            //           ),
            //         ),
            //         FlatButton(
            //           child: Text('Add Todo'),
            //           onPressed: () => bloc.addTodo(_textEditingController.text),
            //         )
            //       ],
            //     )),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text('List of Todos', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .85,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<List<Todo>>(
                  stream: bloc.todos,
                  builder:
                      (BuildContext buildContext, AsyncSnapshot<List<Todo>> todos) {
                    if (todos.hasData) {
                      return ListView.builder(
                        itemCount: todos.data.length,
                        itemBuilder: (BuildContext todosBuildContext, int index) {
                          return todoTile(todos.data[index], bloc, context, index);
                        },
                      );
                    }
                    return Center(
                      child: Text('No Todos'),
                    );
                  }),
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => createDialog(context, bloc, _textEditingController),
          );
        },
      ),
    );
  }
}

Container todoTile(Todo todo, TodosBloc bloc, BuildContext context, int index) {
  return Container(
    color: index % 2 == 0 ? Colors.grey : Colors.blueGrey,
    height: 50,
    width: MediaQuery.of(context).size.width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .15,
          child: Checkbox(
            value: todo.completed,
            onChanged: (val) => bloc.setCheck(val, index),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .65,
          height: 50,
          alignment: Alignment.centerLeft,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Center(
                child: Text(
                  todo.name,
                  style: TextStyle(
                    color: index % 2 == 0 ? Colors.black : Colors.white,
                    fontSize: 16,
                  )
                ),
              )
            ],
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width * .05,
          child: IconButton(
            icon: Icon(Icons.delete_forever_sharp),
            onPressed: () => bloc.deleteTodo(index),
          )
        )
      ]
    )
  );
}