import 'dart:io';

import 'package:pageview/database/sqlite/models/truckien.dart';
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
        await _populateTruckien(db);
        // Can create another tables in here
    });
    didInit = true;
  
  }
  
  Future _createTruckienTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${TrucKien.tblTruckien} ("
          "${TrucKien.dbId} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${TrucKien.dbName} TEXT, "
          "${TrucKien.dbWorkTodo} TEXT, "
          "${TrucKien.dbWorkNotTodo} TEXT);");
    });
  }

  Future _populateTruckien(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute('INSERT INTO ${TrucKien.tblTruckien}(${TrucKien.dbName}, ${TrucKien.dbWorkTodo}, ${TrucKien.dbWorkNotTodo}) '
      'VALUES '
          '("Trực Kiến", "Tốt cho các việc thi ơn huệ, trồng cây cối.", " Xấu cho các việc chôn cất, đào giếng, lợp nhà."), '
          '("Trực Trừ", "Tốt cho các việc trừ phục, cúng giải, cạo đầu", "Xấu cho các việc xuất vốn, hội họp, châm chích."), '
          '("Trực Mãn", "Tốt cho các việc xuất hành, sửa kho, dựng nhà, mở tiệm.", "Xấu cho các việc chôn cất, thưa kiện, xuất vốn, nhậm chức."), '
          '("Trực Bình", "Tốt cho các việc rời bếp, thượng lương, làm chuồng lục súc.", "Xấu cho các việc khai trương, xuất nhập tài vật, giá thú, động thở."), '
          '("Trực Định", "Tốt cho các việc giao dịch, buôn bán, làm chuồng lục súc, thi ơn huệ.", "Xấu cho các việc xuất hành, thưa kiện, châm chích, an sàng."), '
          '("Trực Chấp", "Tốt cho các việc tạo tác, sửa giếng, thu người làm.", "Xấu cho các việc xuất nhập vốn liếng, khai kho, an sàng."), '
          '("Trực Phá", "Tốt cho các việc dỡ nhà, phá vách, ra đi.", "Xấu cho các việc mở cửa hàng, may mặc, sửa kho, hội họp."), '
          '("Trực Nguy", "Tốt cho các việc cúng lễ, may mặc, từ tụng.", "Xấu cho các việc hội họp, châm chích, giá thú, làm chuồng lục súc, khai trương."), '
          '("Trực Thành", "Tốt cho các việc nhập học, giá thú, may mặc, thượng lương.", "Xấu cho các việc kiện tụng, mai táng, châm chích, di cư."), '
          '("Trực Thu", "Tốt cho các việc khai trương, lập kho vựa, giao dịch, may mặc.", "Xấu cho các việc an táng, giá thú, nhậm chức, xuất nhập tài vật."), '
          '("Trực Khai", "Tốt cho các việc làm nhà, động thổ, làm chuồng gia súc, giá thú, đào giếng.", "Xấu cho các việc giao dịch, châm chích, trồng tỉa."), '
          '("Trực Bế", "Tốt cho các việc làm cửa, thượng lương, giá thú, trị bệnh.", "Xấu cho các việc nhậm chức, châm chích, đào giếng, kiện thưa.")');
    });
  }
}