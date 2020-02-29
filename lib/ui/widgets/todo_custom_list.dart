import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/ui/common/snack_bar.dart';
import 'package:flutter_todo/ui/screens/screens.dart';
import 'package:flutter_todo/ui/widgets/widgets.dart';

class TodoCustomList extends StatefulWidget {
  final List<Todo> listCompletedTodo;
  final List<Todo> listIncompleteTodo;
  final RefreshCallback onRefresh;
  final ScrollController controller;

  const TodoCustomList({
    @required this.onRefresh,
    Key key,
    this.listCompletedTodo,
    this.listIncompleteTodo,
    this.controller,
  }) : super(key: key);

  @override
  _TodoCustomListState createState() => _TodoCustomListState();
}

class _TodoCustomListState extends State<TodoCustomList> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        buildSliverList(widget.listIncompleteTodo),
        SliverStickyHeaderBuilder(
          builder: (context, state) => widget.listCompletedTodo == null ||
                  widget.listCompletedTodo.isEmpty
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 40.0 +
                          (state.isPinned
                              ? MediaQuery.of(context).padding.top
                              : 0),
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(1.0 - state.scrollPercentage),
                      padding: EdgeInsets.only(
                          top: state.isPinned
                              ? MediaQuery.of(context).padding.top
                              : 0,
                          left: 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Completed',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
          sliver: buildSliverList(widget.listCompletedTodo),
        ),
      ],
    );
  }

  SliverList buildSliverList(List<Todo> todos) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => TodoItem(
          todo: todos[index],
          onChanged: (todo) {
            BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(todo));
            showUndoSnackBar(context, onUndo: () {
              todo.done = !todo.done;
              BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(todo));
            }, label: todo.done ? "1 completed" : "1 marked incomplete");
          },
          onPressed: () {
            locator<NavigationService>()
                .push(TodoDetailScreen.routeName, arguments: todos[index]);
          },
        ),
        childCount: todos == null ? 0 : todos.length,
      ),
    );
  }
}
