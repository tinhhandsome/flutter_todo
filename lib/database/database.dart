import "dart:async";
import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";

const String todoTable = "Todo";

class DatabaseProvider {
  Database _database;
  Database get database => _database;

  Future boot({String path}) async {
    if (_database != null) {
      return;
    }
    _database = await createDatabase(pathTest: path);
  }

  Future<Database> createDatabase({String pathTest = ""}) async {
    final String databasePath = await getDatabasesPath();

    //"ReactiveTodo.db is our database instance name
    final String path = join(databasePath, "ReactiveTodo.db");
    final database = await openDatabase(pathTest.isNotEmpty ? pathTest : path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future initDB(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $todoTable ("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "done INTEGER, "
        "description TEXT, "
        "expired TEXT"
        ")");
  }

  void dispose() {
    _database.close();
  }
}
