import 'package:pageview/sqlite/models/truckien.dart';

import '../app_db.dart';

class TrucKienRepository {
  static final TrucKienRepository _trucKienRepository =
      TrucKienRepository._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  TrucKienRepository._internal(this._appDatabase);

  static TrucKienRepository get() {
    return _trucKienRepository;
  }

  /// Get All Truc kien
  Future<List<TrucKien>> getTrucKiens() async {
    var db = await _appDatabase.getDb();
    var res = await db.query("${TrucKien.tblTruckien}");
    List<TrucKien> list =
        res.isNotEmpty ? res.map((c) => TrucKien.fromMap(c)).toList() : [];
    return list;
  }

  /// Get Truckien by name
  Future<TrucKien> getTrucKien(String name) async {
    var db = await _appDatabase.getDb();
    var res = await db
        .query("${TrucKien.tblTruckien}", where: "name = ?", whereArgs: [name]);
    return res.isNotEmpty ? TrucKien.fromMap(res.first) : Null;
  }
}
