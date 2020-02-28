@Skip("sqflite cannot run on the machine.")

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/dao/todo.dart';
import 'package:flutter_todo/database/database.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

const String testDBPath = "somepath";

TodoDao dao;
GetIt getIt = GetIt.instance;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());

  group("Todo Database tests", () {
    // Init database
    setUp(() async {
      final String databasePath = await getDatabasesPath();
      await getIt<DatabaseProvider>()
          .boot(path: path.join(databasePath, testDBPath));
      dao = const TodoDao();
    });

    // Delete the database so every test run starts with a fresh database
    tearDownAll(() async {
      final String databasePath = await getDatabasesPath();
      await deleteDatabase(path.join(databasePath, testDBPath));
    });

    test("should insert and query todo by id", () async {
      Todo todo = Todo(
        title: "test",
        expired: 1000,
        done: false,
        description: "test game",
      );
      try {
        var id = await dao.createTodo(todo: todo);
        expect(id, isNotNull);

        var todoQuery = await dao.getTodoById(id: id);

        expect(todoQuery.title, equals(todo.title));
        expect(todoQuery.expired, equals(todo.expired));
        expect(todoQuery.done, equals(todo.done));
        expect(todoQuery.description, equals(todo.description));
      } catch (exception) {
        expect(false, true);
      }
    });

    test("should insert, update and query todo by id", () async {
      Todo todo = Todo(
        title: "test",
        expired: 100,
        done: false,
        description: "test game",
      );
      // Create
      {
        try {
          todo.id = await dao.createTodo(todo: todo);
          expect(todo.id, isNotNull);

          var todoQuery = await dao.getTodoById(id: todo.id);

          expect(todoQuery.title, equals(todo.title));
          expect(todoQuery.expired, equals(todo.expired));
          expect(todoQuery.done, equals(todo.done));
          expect(todoQuery.description, equals(todo.description));
        } catch (exception) {
          expect(false, true);
        }
      }

      // Update
      {
        todo.description = "test update";
        todo.done = true;
        try {
          var affected = await dao.updateTodo(todo: todo);
          expect(affected, 1);

          var todoQuery = await dao.getTodoById(id: todo.id);

          expect(todoQuery.title, equals(todo.title));
          expect(todoQuery.expired, equals(todo.expired));
          expect(todoQuery.done, equals(true));
          expect(todoQuery.description, equals("test update"));
        } catch (exception) {
          expect(false, true);
        }
      }
    });

    test("should insert, delete and query todo by id", () async {
      Todo todo = Todo(
        title: "test",
        expired: 100,
        done: false,
        description: "test game",
      );
      // Create
      {
        try {
          todo.id = await dao.createTodo(todo: todo);
          expect(todo.id, isNotNull);

          var todoQuery = await dao.getTodoById(id: todo.id);

          expect(todoQuery.title, equals(todo.title));
          expect(todoQuery.expired, equals(todo.expired));
          expect(todoQuery.done, equals(todo.done));
          expect(todoQuery.description, equals(todo.description));
        } catch (exception) {
          expect(false, true);
        }
      }

      // Delete
      {
        try {
          var affected = await dao.deleteTodo(id: todo.id);
          expect(affected, 1);

          var todoQuery = await dao.getTodoById(id: todo.id);
          expect(todoQuery, isNull);
        } catch (exception) {
          expect(false, true);
        }
      }
    });
  });
}
