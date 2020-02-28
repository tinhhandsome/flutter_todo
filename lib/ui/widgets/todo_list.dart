import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';

import 'todo_item.dart';

class ListTodo extends StatefulWidget {
  final List<Todo> listTodo;
  final RefreshCallback onRefresh;

  const ListTodo({@required this.onRefresh, Key key, this.listTodo})
      : super(key: key);

  @override
  _ListTodoState createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var todo = widget.listTodo[index];
                return TodoItem(
                  todo: todo,
                );
              },
              childCount: widget.listTodo.length,
            ),
          ),
        ],
      ),
      onRefresh: widget.onRefresh,
    );
  }
}
