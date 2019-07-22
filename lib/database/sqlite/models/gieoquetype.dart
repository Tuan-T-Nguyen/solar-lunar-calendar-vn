class GieoQueType {
  static final tbl = "gieoquetype";
  static final dbId = "id";
  static final dbName = "name";
  static final dbCode = "code";

  int id;
  String name, code;

  GieoQueType({this.id, this.name, this.code});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  GieoQueType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    code = map['code'];
  }
}