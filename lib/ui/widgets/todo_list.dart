import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';

import 'todo_item.dart';

class ListTodo extends StatelessWidget {
  final List<Todo> listTodo;
  final Function(Todo todo) onPressed;
  final Function(Todo todo) onChanged;
  final Function(Todo todo) onDatePressed;

  const ListTodo(
      {Key key,
      this.listTodo,
      this.onPressed,
      this.onChanged,
      this.onDatePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var todo = listTodo[index];
              return TodoItem(
                todo: todo,
                onChanged: onChanged,
                onPressed: () {
                  onPressed(listTodo[index]);
                },
                onDatePressed: () {
                  onDatePressed(listTodo[index]);
                },
              );
            },
            childCount: listTodo.length,
          ),
        ),
      ],
    );
  }
}
