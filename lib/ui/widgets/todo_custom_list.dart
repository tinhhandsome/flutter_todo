import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_todo/generated/l10n.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/ui/widgets/widgets.dart';

class TodoCustomList extends StatelessWidget {
  final List<Todo> listCompletedTodo;
  final List<Todo> listIncompleteTodo;
  final Function(Todo todo) onPressed;
  final Function(Todo todo) onChanged;
  final Function(Todo todo) onDatePressed;

  const TodoCustomList({
    Key key,
    this.listCompletedTodo,
    this.listIncompleteTodo,
    this.onPressed,
    this.onChanged,
    this.onDatePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        buildSliverList(listIncompleteTodo),
        SliverStickyHeaderBuilder(
          builder: (context, state) =>
              listCompletedTodo == null || listCompletedTodo.isEmpty
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
                          child: Text(
                            S.of(context).completedLabel,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        ),
                      ],
                    ),
          sliver: buildSliverList(listCompletedTodo),
        ),
      ],
    );
  }

  SliverList buildSliverList(List<Todo> todos) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => TodoItem(
          todo: todos[index],
          onChanged: onChanged,
          onPressed: () {
            onPressed(todos[index]);
          },
          onDatePressed: () {
            onDatePressed(todos[index]);
          },
        ),
        childCount: todos == null ? 0 : todos.length,
      ),
    );
  }
}
