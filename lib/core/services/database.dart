import 'package:kindergarten/models/message_response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "local_msg_3.db";
  static const _databaseVersion = 1;
  static const table = "msg";
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnCreateAt = 'created_at';
  late Database db;

  DatabaseHelper() {
    _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
   
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT NOT NULL,
    $columnCreateAt TEXT NOT NULL
  )
  ''');
  
  }

  Future<int> insert(Message todo) async {
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    await _initDatabase();
    var res = await db.query(table, orderBy: "$columnId DESC");
    return res;
  }

  Future<int> delete(int id) async {
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    await db.rawQuery("DELETE FROM $table");
  }
}
