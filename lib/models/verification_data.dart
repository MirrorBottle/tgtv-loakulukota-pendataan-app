class VerificationListModel {
  int id;
  String code;
  String date;
  int userId;
  String userName;
  String note;
  int itemsCount;

  VerificationListModel({ 
    required this.id,
    required this.code,
    required this.date,
    required this.userId,
    required this.userName,
    required this.note,
    required this.itemsCount,
  });

  factory VerificationListModel.fromJson(Map<String, dynamic> _json) {
    return VerificationListModel(
      id: _json['id'],
      code: _json['code'],
      date: _json['date'],
      userId: _json['userId'],
      userName: _json['userName'],
      note: _json['note'],
      itemsCount: _json['itemsCount'],
    );
  }
}

class VerificationDetailStockModel {
  int id;
  String code;
  String name;
  String unit;
  int quantity;

  VerificationDetailStockModel({ 
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantity,
  });

  factory VerificationDetailStockModel.fromJson(Map<String, dynamic> _json) {
    return VerificationDetailStockModel(
      id: _json['id'],
      code: _json['code'],
      name: _json['name'],
      unit: _json['unit'],
      quantity: _json['quantity'],
    );
  }
}

class VerificationDetailModel {
  int id;
  String code;
  String date;
  int adminId;
  int userId;
  String userName;
  String adminName;
  String note;
  String validationStatus;
  String validationNote;
  String validatedAt;
  List<VerificationDetailStockModel> stocks;

  VerificationDetailModel({ 
    required this.id,
    required this.code,
    required this.date,
    required this.userId,
    required this.adminId,
    required this.userName,
    required this.adminName,
    required this.note,
    required this.validationStatus,
    required this.validationNote,
    required this.validatedAt,
    this.stocks = const []
  });

  factory VerificationDetailModel.fromJson(Map<String, dynamic> _json) {
    return VerificationDetailModel(
      id: _json['id'],
      code: _json['code'],
      date: _json['date'],
      userId: _json['userId'],
      adminId: _json['adminId'],
      userName: _json['userName'],
      adminName: _json['adminName'],
      note: _json['note'],
      validationStatus: _json['validationStatus'],
      validationNote: _json['validationNote'],
      validatedAt: _json['validatedAt'],
      stocks: _json['stocks'].map<VerificationDetailStockModel>((_shortage){
        return VerificationDetailStockModel.fromJson(_shortage);
      }).toList(),
    );
  }
}



