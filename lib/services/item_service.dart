import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/item_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'http_service.dart';

class ItemService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  ItemService(){
    _http = getIt.get<HTTPService>();
  }

  Future<List<ItemListModel>> list({ String keyword='' }) async {
    Response? _response = await _http?.get("/inventory-item", query: {
      "keyword": keyword
    });
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<ItemListModel> _items = _data['data'].map<ItemListModel>((_item){
        return ItemListModel.fromJson(_item);
      }).toList();
      return _items;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<ItemDetailModel> detail({ required int id }) async {
    Response? _response = await _http?.get("/inventory-item/$id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      ItemDetailModel _item = ItemDetailModel.fromJson(_data['data']);
      return _item;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }
}