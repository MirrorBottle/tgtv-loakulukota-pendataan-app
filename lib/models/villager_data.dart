class VillagerListModel {
  int id;
  String idNumber;
  String name;

  VillagerListModel({ 
    required this.id,
    required this.idNumber,
    required this.name,
  });

  factory VillagerListModel.fromJson(Map<String, dynamic> _json) {
    return VillagerListModel(
      id: _json['id'],
      idNumber: _json['idNumber'],
      name: _json['name'],
    );
  }
}