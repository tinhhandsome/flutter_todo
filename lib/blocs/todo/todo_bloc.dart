import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  Todo _todo;
  Todo get todo => _todo;
  TodoBloc({this.todoRepository = const TodoRepository()});

  @override
  TodoState get initialState => TodoInitialState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoUpdateEvent) {
      yield* _handleUpdateTodoEvent(event);
      return;
    }
    if (event is TodoAddEvent) {
      yield* _handleAddTodoEvent(event);
      return;
    }
    if (event is TodoDeleteEvent) {
      yield* _handleDeleteTodoEvent(event);
      return;
    }
  }

  Stream<TodoState> _handleUpdateTodoEvent(TodoUpdateEvent event) async* {
    yield TodoLoadingState();
    try {
      var todo = await todoRepository.updateTodo(todo: event.todo);
      yield TodoUpdatedState(todo);
    } catch (exception) {
      yield TodoErrorState(exception.message);
    }
  }

  Stream<TodoState> _handleAddTodoEvent(TodoAddEvent event) async* {
    yield TodoLoadingState();
    try {
      var todo = await todoRepository.createTodo(todo: event.todo);
      yield TodoAddedState(todo);
    } catch (exception) {
      yield TodoErrorState(exception.message);
    }
  }

  Stream<TodoState> _handleDeleteTodoEvent(TodoDeleteEvent event) async* {
    yield TodoLoadingState();
    try {
      await todoRepository.deleteTodo(todo: event.todo);
      yield TodoDeletedState(event.todo);
    } catch (exception) {
      yield TodoErrorState(exception.message);
    }
  }
}
