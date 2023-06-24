class DashboardShortageModel {
  int id;
  String code;
  String name;
  String unit;
  int quantity;

  DashboardShortageModel({ 
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory DashboardShortageModel.fromJson(Map<String, dynamic> _json) {
    return DashboardShortageModel(
      id: _json['id'],
      code: _json['code'],
      name: _json['name'],
      unit: _json['unit'],
      quantity: _json['quantity'],
    );
  }
}

class DashboardModel {
  String inventoryIn;
  String inventoryOut;
  List<DashboardShortageModel> shortages;

  DashboardModel({
    this.inventoryIn = '-',
    this.inventoryOut = '-',
    this.shortages = const []
  });

  factory DashboardModel.fromJson(Map<String, dynamic> _json) {
    return DashboardModel(
      inventoryIn: _json['inventoryIn'],
      inventoryOut: _json['inventoryOut'],
      shortages: _json['shortages'].map<DashboardShortageModel>((_shortage){
        return DashboardShortageModel.fromJson(_shortage);
      }).toList(),
    );
  }
}