import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  TodoBloc todoBloc;
  MockTodoRepository todoRepository;

  setUp(() {
    todoRepository = MockTodoRepository();
    todoBloc = TodoBloc(todoRepository: todoRepository);
  });

  tearDown(() {
    todoBloc?.close();
  });

  group("TodoBloc", () {
    {
      var todo = Todo(title: "test", done: false);
      blocTest<TodoBloc, TodoEvent, TodoState>(
        'emits [TodoLoadingState(), TodoAddedState]'
        'when successful',
        build: () async {
          when(todoRepository.createTodo(todo: todo))
              .thenAnswer((_) async => Todo(id: 1, title: "test", done: false));
          return todoBloc;
        },
        act: (bloc) async => todoBloc.add(TodoAddEvent(todo)),
        expect: [
          TodoLoadingState(),
          TodoAddedState(todo..id = 1),
        ],
      );
    }

    {
      var todo = Todo(title: "test", done: false);
      blocTest<TodoBloc, TodoEvent, TodoState>(
        'emits [TodoLoadingState(), TodoUpdatedState]'
        'when successful',
        build: () async {
          todo.id = 1;
          todo.description = "test game";
          when(todoRepository.updateTodo(todo: todo))
              .thenAnswer((_) async => todo);
          return todoBloc;
        },
        act: (bloc) async => todoBloc.add(TodoUpdateEvent(todo)),
        expect: [
          TodoLoadingState(),
          TodoUpdatedState(todo),
        ],
      );
    }

    {
      var todo = Todo(title: "test", done: false);
      blocTest<TodoBloc, TodoEvent, TodoState>(
        'emits [TodoLoadingState(), TodoDeletedState]'
        'when successful',
        build: () async {
          todo.id = 1;
          when(todoRepository.deleteTodo(todo: todo))
              .thenAnswer((_) async => true);
          return todoBloc;
        },
        act: (bloc) async => todoBloc.add(TodoDeleteEvent(todo)),
        expect: [
          TodoLoadingState(),
          const TodoDeletedState(true),
        ],
      );
    }

    {
      Todo completed = Todo(id: 1, done: true, title: "compeleted");
      Todo inCompleted = Todo(id: 1, done: false, title: "inCompeleted");

      blocTest<TodoBloc, TodoEvent, TodoState>(
        'emits [TodoLoadingState(), TodoAllLoadedState]'
        'when successful',
        build: () async {
          when(todoRepository.getAll())
              .thenAnswer((_) async => [completed, inCompleted]);

          when(todoRepository.getAllTodoCompleted())
              .thenAnswer((_) async => [completed]);

          when(todoRepository.getAllTodoInCompleted())
              .thenAnswer((_) async => [inCompleted]);
          return todoBloc;
        },
        act: (bloc) async => todoBloc.add(TodoLoadAllEvent()),
        expect: [
          TodoLoadingState(),
          TodoLoadedAllState({
            AppTabs.all: [completed, inCompleted],
            AppTabs.completed: [completed],
            AppTabs.inCompleted: [inCompleted],
          }),
        ],
      );
    }
  });
}
