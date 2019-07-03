import 'package:pageview/sqlite/models/truckien.dart';
import 'package:sqflite/sqflite.dart';

import '../app_db.dart';

class TrucKienRepository {
  static final TrucKienRepository _trucKienRepository = TrucKienRepository._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  TrucKienRepository._internal(this._appDatabase);

  static TrucKienRepository get() {
    return _trucKienRepository;
  }

  // Populate data
  Future populateData() async{
    var dbClient = await _appDatabase.getDb();
    await dbClient.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT INTO ${TrucKien.tblTruckien}(${TrucKien.dbName}, ${TrucKien.dbWorkTodo}, ${TrucKien.dbWorkNotTodo}) '
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
    });
  }

   /// Get All Truc kien
  Future<List<TrucKien>> getTrucKiens() async {
    var db = await _appDatabase.getDb();
    var res = await db.query("${TrucKien.tblTruckien}");
    List<TrucKien> list = res.isNotEmpty ? res.map((c) => TrucKien.fromMap(c)).toList() : [];
    return list;
  }

}