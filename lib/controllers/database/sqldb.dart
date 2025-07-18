import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "habitsTracker.db");
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE 'habits' (
      'id' INTEGER PRIMARY KEY AUTOINCREMENT,
      'nameHabit' TEXT,
      'descHabit' TEXT,
      'subTasks' TEXT,
      'frequency' TEXT,
      'icon' TEXT,
      'baseIcon' TEXT,
      'dateTime' TEXT,
      'completedDays' TEXT
    )
""");
    print("create table database =================================");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade =================================");
  }

  readData (String sql) async {
    Database? myDb  = await db;
    List<Map> response = await myDb!.rawQuery(sql); 
    return response;
}
  updateData (String sql) async {
    Database? myDb  = await db;
    int response = await myDb!.rawUpdate(sql); 
    return response;
}
  insertData (String sql) async {
    Database? myDb  = await db;
    int response = await myDb!.rawInsert(sql); 
    return response;
}
  deleteData (String sql) async {
    Database? myDb  = await db;
    int response = await myDb!.rawDelete(sql); 
    return response;
}

}