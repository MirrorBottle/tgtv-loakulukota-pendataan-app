class ItemListModel {
  int id;
  String code;
  String name;
  String unit;
  int stock;

  ItemListModel({ 
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.stock,
  });

  factory ItemListModel.fromJson(Map<String, dynamic> _json) {
    return ItemListModel(
      id: _json['id'],
      code: _json['code'],
      name: _json['name'],
      unit: _json['unit'],
      stock: _json['stock'],
    );
  }
}

class ItemDetailModel {
  int id;
  String code;
  String name;
  String unit;
  int stock;
  String description;
  int lowQuantity;
  int inventoryCategoryId;
  String inventoryCategoryName;


  ItemDetailModel({ 
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.stock,
    required this.description,
    required this.lowQuantity,
    required this.inventoryCategoryId,
    required this.inventoryCategoryName
  });

  factory ItemDetailModel.fromJson(Map<String, dynamic> _json) {
    return ItemDetailModel(
      id: _json['id'],
      code: _json['code'],
      name: _json['name'],
      unit: _json['unit'],
      stock: _json['stock'],
      description: _json['description'],
      lowQuantity: _json['lowQuantity'],
      inventoryCategoryId: _json['inventoryCategoryId'],
      inventoryCategoryName: _json['inventoryCategoryName'],
    );
  }
}