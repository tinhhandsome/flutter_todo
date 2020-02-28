import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_bloc.dart';
import 'package:flutter_todo/blocs/todo/todo_state.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import './bloc.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final Map<AppTabs, List<Todo>> mapTodo = {};
  final TodoRepository todoRepository;

  final TodoBloc todoBloc;
  StreamSubscription todoSubscription;

  TasksBloc({
    this.todoRepository = const TodoRepository(),
    this.todoBloc,
  }) {
    if (todoBloc != null) {
      todoSubscription = todoBloc.listen((state) {
        if (state is TodoAddedState) {
          add(TasksLoadAllTodoEvent());
        }
        if (state is TodoDeletedState) {
          add(TasksLoadAllTodoEvent());
        }
        if (state is TodoUpdatedState) {
          add(TasksLoadAllTodoEvent());
        }
      });
    }
  }

  @override
  TasksState get initialState => TasksInitialState();

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    if (event is TasksLoadAllTodoEvent) {
      yield* _handleLoadAllTodoEvent(event);
      return;
    }
  }

  Stream<TasksState> _handleLoadAllTodoEvent(
      TasksLoadAllTodoEvent event) async* {
    yield TasksLoadingState();
    try {
//      mapTodo[AppTabs.all] = [];
      mapTodo[AppTabs.all] = await todoRepository.getAll();

      mapTodo[AppTabs.completed] = await todoRepository.getAllTodoCompleted();
      mapTodo[AppTabs.inCompleted] =
          await todoRepository.getAllTodoInCompleted();
//      mapTodo[AppTabs.all].addAll(mapTodo[AppTabs.inCompleted]);
//      mapTodo[AppTabs.all].addAll(mapTodo[AppTabs.completed]);

      yield TasksLoadedAllTodoState(mapTodo);
    } catch (exception) {
      yield TasksErrorState(exception.toString());
    }
  }

  @override
  Future<void> close() {
    todoSubscription?.cancel();
    return super.close();
  }
}
