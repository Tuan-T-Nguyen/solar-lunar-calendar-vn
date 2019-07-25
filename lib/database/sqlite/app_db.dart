import 'dart:io';

import 'package:pageview/database/sqlite/models/gieoquetype.dart';
import 'package:pageview/database/sqlite/models/truckien.dart';
import 'package:pageview/utils/constants.dart';
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
    String path = await _getPath();
    _database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await _createTruckienTable(db);
        await _populateTruckien(db);
        await _createGieoQueTypeTable(db);
        await _populateGieoQueType(db);
        // Can create another tables in here
    });
    didInit = true;
  }

  Future<String> _getPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      return join(documentsDirectory.parent.path, "databases/lichphattai.db");
    } else {
      return join(documentsDirectory.path, "lichphattai.db");
    }
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

  // Todo sync from server at begin of install app
  Future _populateTruckien(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute('INSERT INTO ${TrucKien.tblTruckien}(${TrucKien.dbName}, ${TrucKien.dbWorkTodo}, ${TrucKien.dbWorkNotTodo}) '
      'VALUES '
          '("Trực Kiến", "Tốt cho các việc thi ơn huệ, trồng cây cối.", "Xấu cho các việc chôn cất, đào giếng, lợp nhà."), '
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

  Future _createGieoQueTypeTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${GieoQueType.tbl} ("
          "${GieoQueType.dbId} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${GieoQueType.dbName} TEXT, "
          "${GieoQueType.dbCode} TEXT );");
    });
  }

  Future _populateGieoQueType(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute('INSERT INTO ${GieoQueType.tbl}(${GieoQueType.dbCode}, ${GieoQueType.dbName}) '
          'VALUES '
          '("${GIEOQUE_CODE.ALL}", "Tất cả"), '
          '("${GIEOQUE_CODE.UOC_MUON}", "Ước muốn"), '
          '("${GIEOQUE_CODE.HON_NHAN}", "Hôn nhân"), '
          '("${GIEOQUE_CODE.TINH_YEU}", "Tình yêu"), '
          '("${GIEOQUE_CODE.GIA_DAO}", "Gia đạo"), '
          '("${GIEOQUE_CODE.CON_CAI}", "Con cái"), '
          '("${GIEOQUE_CODE.VAY_VON}", "Vay vốn"), '
          '("${GIEOQUE_CODE.KINH_DOANH}", "Kinh doanh"), '
          '("${GIEOQUE_CODE.CHUNG_KHOAN}", "Thị trường chứng khoán"), '
          '("${GIEOQUE_CODE.TUOI_THO}", "Tuổi thọ"), '
          '("${GIEOQUE_CODE.BENH_TAT}", "Bệnh tật"), '
          '("${GIEOQUE_CODE.CHO_NGUOI}", "Chờ người"), '
          '("${GIEOQUE_CODE.TIM_NGUOI}", "Tìm người"), '
          '("${GIEOQUE_CODE.VAT_BI_MAT}", "Vật bị mất"), '
          '("${GIEOQUE_CODE.DU_LICH}", "Du lịch"), '
          '("${GIEOQUE_CODE.KIEN_TUNG}", "Kiện tụng"), '
          '("${GIEOQUE_CODE.VIEC_LAM}", "Việc làm"), '
          '("${GIEOQUE_CODE.THI_CU}", "Thi cử"), '
          '("${GIEOQUE_CODE.NGHE_NGHIEP}", "Nghề nghiệp"), '
          '("${GIEOQUE_CODE.THOI_TIET}", "Thời tiêt"), '
          '("${GIEOQUE_CODE.SU_NGHIEP}", "Sự nghiệp"), '
          '("${GIEOQUE_CODE.NHAM_CHUC}", "Nhậm chức"), '
          '("${GIEOQUE_CODE.XUAT_HANH_DI_XA}", "Xuất hành đi xa"), '
          '("${GIEOQUE_CODE.SU_VIEC}", "Sự việc")');
    });
  }
}