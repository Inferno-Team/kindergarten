import 'package:kindergarten/models/message_response.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal() {
    initDatabase();
  }
  static const _databaseName = "local_msg.db";
  static const _databaseVersion = 1;
  static const table = "msg";
  static const settingsTable = 'settings';
  static const sentMessagesTable = 'sent';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnCreateAt = 'created_at';
  static const columnKey = 'key';
  static const columnValue = 'value';
  bool _firstTime = false;
  Database? db;

  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database _db, int version) async {
    _firstTime = true;
    await _db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT NOT NULL,
    $columnCreateAt TEXT NOT NULL
  ) 
  ''');
    await _db.execute('''
  CREATE TABLE $settingsTable (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnKey TEXT NOT NULL,
    $columnValue TEXT NOT NULL
  ) 
  ''');
    await _db.execute('''
  CREATE TABLE $sentMessagesTable (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT NOT NULL,
    $columnCreateAt TEXT NOT NULL
  ) 
  ''');
  }

  Future<int> insert(Message msg) async {
    if (db == null) return 0;
    var res = await db!.insert(table, msg.toMap());
    print("res : $res");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    // await _initDatabase();
    print('_firstTime : $_firstTime');
    if (db == null) return [];
    if (_firstTime) {
      print('data will be inserted');
      for (int i = 0; i < 10; i++) {
        insert(Message(text: "Message Title #$i", createdAt: DateTime.now()));
      }
      _firstTime = false;
    }

    var res = await db!.query(table);
    return res;
  }

  Future<dynamic> getPhoneNumber() async {
    if (_firstTime) {
      var x = await insertPhoneNumber('0943581149');
      print('X : $x');
    }
    var res = await db!
        .query(settingsTable, where: 'key=?', whereArgs: ['number'], limit: 1);
    return res;
  }

  Future<int> insertPhoneNumber(number) async {
    var res =
        await db!.insert(settingsTable, {'key': 'number', 'value': number});
    print("insertPhoneNumber : $res");
    return res;
  }

  Future<int> updatePhoneNumber(number) async {
    var res = await db!.update(
      settingsTable,
      {
        'value': number,
      },
      where: 'key=?',
      whereArgs: ['number'],
    );
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllSentMessages() async =>
      await db!.query(sentMessagesTable);
  Future<int> insertSentMessage(Message msg) async =>
      await db!.insert(sentMessagesTable, msg.toMap());
}
