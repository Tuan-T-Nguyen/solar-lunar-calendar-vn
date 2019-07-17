class XuatHanh {
  final int id;
  final int surplus, status;
  final String name, description, poem;

  XuatHanh({this.id, this.surplus, this.name, this.status, this.description, this.poem});

  factory XuatHanh.fromJson(Map<String, dynamic> json) {
    return new XuatHanh(
        id: json['id'],
        surplus: json['surplus'],
        name: json['name'],
        status: json['status'],
        description: json['description'],
        poem: json['poem'],
    );
  }
//  XuatHanh.fromJson(Map<String, dynamic> json)
//    : id = json['id'],
//      surplus = json['surplus'],
//      status = json['status'],
//      description = json['description'],
//      poem = json['poem'];

//  Map<String, dynamic> toJson() =>
//      {
//        'id': id,
//        'surplus': surplus,
//        'status': status,
//        'description': description,
//        'poem': poem,
//      };
}