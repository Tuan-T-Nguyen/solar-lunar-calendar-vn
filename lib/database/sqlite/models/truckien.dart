class TrucKien {
  static final tblTruckien = "truckien";
  static final dbId = "id";
  static final dbName = "name";
  static final dbWorkTodo = "workTodo";
  static final dbWorkNotTodo = "workNotTodo";

  int id;
  String name, workTodo, workNotTodo;

  TrucKien({this.id, this.name, this.workTodo, this.workNotTodo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'workTodo': workTodo,
      'workNotTodo': workNotTodo,
    };
  }

  TrucKien.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    workTodo = map['workTodo'];
    workNotTodo = map['workNotTodo'];
  }
}