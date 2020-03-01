import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/ui/common/show_date_time_picker.dart';
import 'package:flutter_todo/ui/screens/screens.dart';
import 'package:flutter_todo/utils/themes/themes.dart';

import 'todo_item.dart';

class ListTodo extends StatefulWidget {
  final List<Todo> listTodo;
  final RefreshCallback onRefresh;
  final ScrollController controller;

  const ListTodo(
      {@required this.onRefresh, Key key, this.listTodo, this.controller})
      : super(key: key);

  @override
  _ListTodoState createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
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
              var todo = widget.listTodo[index];
              return TodoItem(
                todo: todo,
                onChanged: (todo) {
                  if (todo.done) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(TodoCompleteEvent(todo));
                  } else {
                    BlocProvider.of<TodoBloc>(context)
                        .add(TodoMarkIncompleteEvent(todo));
                  }
                },
                onPressed: () {
                  locator<NavigationService>()
                      .push(TodoDetailScreen.routeName, arguments: todo);
                },
                onDatePressed: () {
                  var todo = widget.listTodo[index];
                  showDateTimePicker(
                    context,
                    current: todo.expired != null && todo.expired > 0
                        ? DateTime.fromMillisecondsSinceEpoch(todo.expired)
                        : DateTime.now(),
                    onConfirm: (pick) {
                      todo.expired = pick.millisecondsSinceEpoch;
                      BlocProvider.of<TodoBloc>(context)
                          .add(TodoUpdateEvent(todo));
                    },
                  );
                },
              );
            },
            childCount: widget.listTodo.length,
          ),
        ),
      ],
    );
  }
}
