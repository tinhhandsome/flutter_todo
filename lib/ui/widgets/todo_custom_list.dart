import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_event.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/sevices/services.dart';
import 'package:flutter_todo/ui/screens/screens.dart';
import 'package:flutter_todo/ui/widgets/widgets.dart';

class TodoCustomList extends StatefulWidget {
  final List<Todo> listCompletedTodo;
  final List<Todo> listInCompletedTodo;
  final RefreshCallback onRefresh;

  const TodoCustomList({
    @required this.onRefresh,
    Key key,
    this.listCompletedTodo,
    this.listInCompletedTodo,
  }) : super(key: key);

  @override
  _TodoCustomListState createState() => _TodoCustomListState();
}

class _TodoCustomListState extends State<TodoCustomList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => TodoItem(
                todo: widget.listInCompletedTodo[index],
                onChanged: (todo) {
                  BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(todo));
                },
                onPressed: () {
                  locator<NavigationService>().push(TodoDetailScreen.routeName,
                      arguments: widget.listInCompletedTodo[index]);
                },
              ),
              childCount: widget.listInCompletedTodo == null
                  ? 0
                  : widget.listInCompletedTodo.length,
            ),
          ),
          SliverStickyHeaderBuilder(
            builder: (context, state) => widget.listCompletedTodo == null ||
                    widget.listCompletedTodo.isEmpty
                ? Container()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(1.0 - state.scrollPercentage),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => TodoItem(
                  todo: widget.listCompletedTodo[index],
                  onChanged: (todo) {
                    BlocProvider.of<TodoBloc>(context)
                        .add(TodoUpdateEvent(todo));
                  },
                  onPressed: () {
                    locator<NavigationService>().push(
                        TodoDetailScreen.routeName,
                        arguments: widget.listCompletedTodo[index]);
                  },
                ),
                childCount: widget.listCompletedTodo == null
                    ? 0
                    : widget.listCompletedTodo?.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
