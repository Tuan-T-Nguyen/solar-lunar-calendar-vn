import 'dart:io';

import 'package:pageview/sqlite/models/truckien.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();
  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "lichvannien.db");
    _database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await _createTruckienTable(db);
        // Can create another tables in here
    });
    didInit = true;
  
  }
  
  Future _createTruckienTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${TrucKien.tblTruckien} ("
          "${TrucKien.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${TrucKien.dbName} TEXT,"
          "${TrucKien.dbWorkTodo} TEXT,"
          "${TrucKien.dbWorkNotTodo} TEXT;)");
    });
  }
}