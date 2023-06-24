import 'package:loakulukota_app/models/item_data.dart';

class InventoryLogHistoryModel {
  int id;
  String code;
  String date;
  int userId;
  String userName;
  String note;
  String type;
  int itemsCount;

  InventoryLogHistoryModel({ 
    required this.id,
    required this.code,
    required this.date,
    required this.userId,
    required this.userName,
    required this.note,
    required this.type,
    required this.itemsCount,
  });

  factory InventoryLogHistoryModel.fromJson(Map<String, dynamic> _json) {
    return InventoryLogHistoryModel(
      id: _json['id'],
      code: _json['code'],
      date: _json['date'],
      userId: _json['userId'],
      userName: _json['userName'],
      note: _json['note'],
      type: _json['type'],
      itemsCount: _json['itemsCount'],
    );
  }
}

class InventoryLogDetailModelDetailStockModel {
  int id;
  String code;
  String name;
  String unit;
  int quantity;

  InventoryLogDetailModelDetailStockModel({ 
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory InventoryLogDetailModelDetailStockModel.fromJson(Map<String, dynamic> _json) {
    return InventoryLogDetailModelDetailStockModel(
      id: _json['id'],
      code: _json['code'],
      name: _json['name'],
      unit: _json['unit'],
      quantity: _json['quantity'],
    );
  }
}

class InventoryLogDetailModel {
  int id;
  String code;
  String date;
  int adminId;
  int userId;
  String userName;
  String adminName;
  String note;
  String type;
  String validationStatus;
  String validationNote;
  String validatedAt;
  List<InventoryLogDetailModelDetailStockModel> stocks;

  InventoryLogDetailModel({ 
    required this.id,
    required this.code,
    required this.date,
    required this.userId,
    required this.adminId,
    required this.userName,
    required this.adminName,
    required this.note,
    required this.type,
    required this.validationStatus,
    required this.validationNote,
    required this.validatedAt,
    this.stocks = const []
  });

  factory InventoryLogDetailModel.fromJson(Map<String, dynamic> _json) {
    return InventoryLogDetailModel(
      id: _json['id'],
      code: _json['code'],
      date: _json['date'],
      userId: _json['userId'],
      adminId: _json['adminId'],
      userName: _json['userName'],
      adminName: _json['adminName'],
      note: _json['note'],
      type: _json['type'],
      validationStatus: _json['validationStatus'],
      validationNote: _json['validationNote'],
      validatedAt: _json['validatedAt'],
      stocks: _json['stocks'].map<InventoryLogDetailModelDetailStockModel>((_shortage){
        return InventoryLogDetailModelDetailStockModel.fromJson(_shortage);
      }).toList(),
    );
  }
}

class InventoryCreateStockModel {
  int id;
  ItemListModel? item;
  int quantity;
  InventoryCreateStockModel({this.item, this.quantity = 0, this.id = 0});

  Map<String, dynamic> toJson() => {
    "inventory_item_id": item!.id,
    "stock": item!.stock,
    "quantity": quantity,
  };
}