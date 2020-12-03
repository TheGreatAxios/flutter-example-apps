import 'package:flutter/material.dart';
import 'package:flutter_rxdart_hive/todos.bloc.dart';

createDialog(BuildContext context, TodosBloc bloc, TextEditingController controller) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Container(
        height: 200,
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text('Add Todo', style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,),
            TextField(
              controller: controller,

            ),
            FlatButton(
              child: Text('Add Todo'),
              onPressed: () => bloc.addTodo(controller.text),
            )
          ],
        )
    ),
  );
}