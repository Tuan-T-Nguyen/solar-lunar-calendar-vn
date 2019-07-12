import 'dart:async';

import 'package:pageview/sqlite/models/truckien.dart';
import 'package:pageview/sqlite/repository/truckien_repository.dart';

import 'bloc_provider.dart';

class TruckienBloc implements BlocBase {
  StreamController<TrucKien> _truckienController = StreamController<TrucKien>.broadcast();
  Stream<TrucKien> get truckien => _truckienController.stream;

  TrucKienRepository _truckienRepository;

  TruckienBloc(this._truckienRepository);

  @override
  void dispose() {
    _truckienController.close();
  }

  void getTrucKien(String name) async {
    TrucKien trucKien = await _truckienRepository.getTrucKien(name);
    _truckienController.sink.add(trucKien);
  }
}