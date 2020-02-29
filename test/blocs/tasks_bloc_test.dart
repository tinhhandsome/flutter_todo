import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/blocs/blocs.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  TasksBloc tasksBloc;
  MockTodoRepository todoRepository;

  setUp(() {
    todoRepository = MockTodoRepository();
    tasksBloc = TasksBloc(todoRepository: todoRepository);
  });

  tearDown(() {
    tasksBloc?.close();
  });

  group("TasksBloc", () {
    {
      Todo completed = Todo(id: 1, done: true, title: "compeleted");
      Todo inCompleted = Todo(id: 1, done: false, title: "inCompeleted");

      blocTest<TasksBloc, TasksEvent, TasksState>(
        'emits [TasksLoadingState(), TasksLoadedAllTodoState]'
        'when successful',
        build: () async {
          when(todoRepository.getAll()).thenAnswer((_) async => []);

          when(todoRepository.getAllTodoCompleted())
              .thenAnswer((_) async => [completed]);

          when(todoRepository.getAllTodoIncomplete())
              .thenAnswer((_) async => [inCompleted]);
          return tasksBloc;
        },
        act: (bloc) async => tasksBloc.add(TasksLoadAllTodoEvent()),
        expect: [
          TasksLoadingState(),
          TasksLoadedAllTodoState({
            AppTabs.all: [],
            AppTabs.completed: [completed],
            AppTabs.incomplete: [inCompleted],
          }),
        ],
      );
    }
  });
}
