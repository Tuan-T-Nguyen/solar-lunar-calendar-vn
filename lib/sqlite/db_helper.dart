import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';

import 'package:pageview/sqlite/models/truckien.dart';

class DBHelper {
  static Database _db;
  static const String TABLE_TRUCKIEN = 'truckien';
  static const String DB_NAME = 'lichphattai.db';


  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE $TABLE_TRUCKIEN (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, workTodo TEXT, workNotTodo TEXT)");
      },
      version: 1,
    );
//    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, DB_NAME);
//    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE_TRUCKIEN (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, workTodo TEXT, workNotTodo TEXT)");
  }

  Future<void> populateData() async{
    var dbClient = await db;
    dbClient.rawInsert('INSERT INTO $TABLE_TRUCKIEN(name, workTodo, workNotTodo) '
        'VALUES '
        '("Trực Kiên", "Tốt cho các việc thi ơn huệ, trồng cây cối.", " Xấu cho các việc chôn cất, đào giếng, lợp nhà."), '
        '("Trực Trừ", "Tốt cho các việc trừ phục, cúng giải, cạo đầu", "Xấu cho các việc xuất vốn, hội họp, châm chích."), '
        '("Trực Mãn", "Tốt cho các việc xuất hành, sửa kho, dựng nhà, mở tiệm.", "Xấu cho các việc chôn cất, thưa kiện, xuất vốn, nhậm chức."), '
        '("Trực Bình", "Tốt cho các việc rời bếp, thượng lương, làm chuồng lục súc.", "Xấu cho các việc khai trương, xuất nhập tài vật, giá thú, động thở."), '
        '("Trực Định", "Tốt cho các việc giao dịch, buôn bán, làm chuồng lục súc, thi ơn huệ.", "Xấu cho các việc xuất hành, thưa kiện, châm chích, an sàng."), '
        '("Trực Chấp", "Tốt cho các việc tạo tác, sửa giếng, thu người làm.", "Xấu cho các việc xuất nhập vốn liếng, khai kho, an sàng."), '
        '("Trực Phá", "Tốt cho các việc dỡ nhà, phá vách, ra đi.", "Xấu cho các việc mở cửa hàng, may mặc, sửa kho, hội họp."), '
        '("Trực Nguy", "Tốt cho các việc cúng lễ, may mặc, từ tụng.", "Xấu cho các việc hội họp, châm chích, giá thú, làm chuồng lục súc, khai trương."), '
        '("Trực Thành", "Tốt cho các việc nhập học, giá thú, may mặc, thượng lương.", "Xấu cho các việc kiện tụng, mai táng, châm chích, di cư."), '
        '("Trực Thâu", "Tốt cho các việc khai trương, lập kho vựa, giao dịch, may mặc.", "Xấu cho các việc an táng, giá thú, nhậm chức, xuất nhập tài vật."), '
        '("Trực Khai", "Tốt cho các việc làm nhà, động thổ, làm chuồng gia súc, giá thú, đào giếng.", "Xấu cho các việc giao dịch, châm chích, trồng tỉa."), '
        '("Trực Bế", "Tốt cho các việc làm cửa, thượng lương, giá thú, trị bệnh.", "Xấu cho các việc nhậm chức, châm chích, đào giếng, kiện thưa."), '
        '');
    //return ids;
  }

  Future<void> insertTruckien(TrucKien trucKien) async {
    var dbClient = await db;
    await dbClient.insert(TABLE_TRUCKIEN, trucKien.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<TrucKien> save(TrucKien trucKien) async {
    var dbClient = await db;
    trucKien.id = await dbClient.insert(TABLE_TRUCKIEN, trucKien.toMap());
    return trucKien;
  }

  Future<List<TrucKien>> getTruckiens() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE_TRUCKIEN, columns: ['id', 'name', 'workTodo', 'workNotTodo']);
    List<TrucKien> truckiens = [];
    if (maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        truckiens.add(TrucKien.fromMap(maps[i]));
      }
    }
    return truckiens;
  }
  
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE_TRUCKIEN, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TrucKien trucKien) async {
    var dbClient = await db;
    return await dbClient.update(TABLE_TRUCKIEN, trucKien.toMap(), where: 'id = ?', whereArgs: [trucKien.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}