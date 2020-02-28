import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  @override
  TodoState get initialState => TodoInitialState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    // TODO: Add Logic
  }


  Stream<TodoState> _handleUpdateTodoTodoEvent(
      TodoUpdateEvent event) async* {
    yield TodoLoadingState();
    try {
//      awa
//      yield TodoUpdatedState(event.settings);
    } catch (exception) {
      yield TodoErrorState(exception.toString());
    }
  }
}
