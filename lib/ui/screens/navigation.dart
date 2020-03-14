import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/generated/l10n.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/services/services.dart';
import 'package:flutter_todo/ui/common/bottom_sheets.dart';
import 'package:flutter_todo/ui/common/show_date_time_picker.dart';
import 'package:flutter_todo/ui/common/snack_bar.dart';
import 'package:flutter_todo/ui/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'screens.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final TabsBloc _tabsBloc = TabsBloc();
  final PageController _pageController = PageController();
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {});
    BlocProvider.of<TasksBloc>(context).add(TasksLoadAllTodoEvent());
    BlocProvider.of<TodoBloc>(context).listen((state) {
      if (state is TodoErrorState) {
        Fluttertoast.showToast(msg: state.message);
      }
    });
    BlocProvider.of<TasksBloc>(context).listen((state) {
      if (state is TasksErrorState) {
        Fluttertoast.showToast(msg: state.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoDeletedState) {
              showUndoSnackBar(context, onUndo: () {
                BlocProvider.of<TodoBloc>(context)
                    .add(TodoAddEvent(state.todo));
              }, label: S.of(context).oneDeletedMessage("1"));
            }
            if (state is TodoCompletedState) {
              showUndoSnackBar(context, onUndo: () {
                state.todo.done = false;
                BlocProvider.of<TodoBloc>(context)
                    .add(TodoUpdateEvent(state.todo));
              }, label: S.of(context).oneCompletedMessage("1"));
            }
            if (state is TodoMarkedIncompleteState) {
              showUndoSnackBar(context, onUndo: () {
                state.todo.done = true;
                BlocProvider.of<TodoBloc>(context)
                    .add(TodoUpdateEvent(state.todo));
              }, label: S.of(context).oneMarkedIncompleteMessage("1"));
            }
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverAppBar(
                    pinned: false,
                    expandedHeight: 86,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        S.of(context).myTasksTitle,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: BlocBuilder<TasksBloc, TasksState>(
                builder: (context, taskState) {
              var pages =
                  _buildPages(BlocProvider.of<TasksBloc>(context).mapTodo);
              return PageView(
                onPageChanged: _selectPage,
                controller: _pageController,
                children: pages,
              );
            }),
          ),
        ),
        floatingActionButton: _buildAddButton(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  List<Widget> _buildPages(Map<AppTabs, List<Todo>> mapTodo) {
    return mapTodo.keys.toList().map((key) {
      Widget child;
      if (key == AppTabs.all) {
        child = TodoCustomList(
          listCompletedTodo: mapTodo[AppTabs.completed],
          listIncompleteTodo: mapTodo[AppTabs.incomplete],
          onDatePressed: onDatePressed,
          onPressed: onPressed,
          onChanged: onChanged,
        );
      } else {
        child = ListTodo(
          listTodo: mapTodo[key],
          onDatePressed: onDatePressed,
          onPressed: onPressed,
          onChanged: onChanged,
        );
      }
      return RefreshIndicator(
        child: child,
        onRefresh: onRefresh,
      );
    }).toList();
  }

  Widget _buildBottomNavigationBar() {
    final Map<AppTabs, String> displayName = {
      AppTabs.all: S.of(context).allLabel,
      AppTabs.completed: S.of(context).completedLabel,
      AppTabs.incomplete: S.of(context).incompleteLabel,
    };

    return BlocBuilder<TabsBloc, TabsState>(
        bloc: _tabsBloc,
        builder: (context, snapshot) {
          return BottomNavigationBar(
              currentIndex: _tabsBloc.tab.index,
              onTap: (index) {
                _selectPage(index);
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.format_list_bulleted,
                  ),
                  title: Text(displayName[AppTabs.all]),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  title: Text(displayName[AppTabs.completed]),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  title: Text(displayName[AppTabs.incomplete]),
                )
              ]);
        });
  }

  Widget _buildAddButton() {
    return FloatingActionButton(
      onPressed: () {
        showAddTodoBottomSheet(context, (todo) {
          BlocProvider.of<TodoBloc>(context).add(TodoAddEvent(todo));
        });
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void onChanged(Todo todo) {
    if (todo.done) {
      BlocProvider.of<TodoBloc>(context).add(TodoCompleteEvent(todo));
    } else {
      BlocProvider.of<TodoBloc>(context).add(TodoMarkIncompleteEvent(todo));
    }
  }

  void onPressed(Todo todo) {
    locator<NavigationService>()
        .push(TodoDetailScreen.routeName, arguments: todo);
  }

  void onDatePressed(Todo todo) {
    showDateTimePicker(
      context,
      current: todo.expired != null && todo.expired > 0
          ? DateTime.fromMillisecondsSinceEpoch(todo.expired)
          : DateTime.now(),
      onConfirm: (pick) {
        todo.expired = pick.millisecondsSinceEpoch;
        BlocProvider.of<TodoBloc>(context).add(TodoUpdateEvent(todo));
      },
    );
  }

  Future<bool> _onWillPop() async {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      await Fluttertoast.showToast(msg: S.of(context).backAgainToLeaveMessage);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> onRefresh() async {
    BlocProvider.of<TasksBloc>(context).add(TasksLoadAllTodoEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  void _selectPage(int index) {
    _tabsBloc.add(TabsSelectTabEvent(AppTabs.values[index]));
  }

  @override
  void dispose() {
    super.dispose();
    _tabsBloc?.close();
  }
}
