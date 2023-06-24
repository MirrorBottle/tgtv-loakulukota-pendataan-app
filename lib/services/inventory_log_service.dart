import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/inventory_log_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'http_service.dart';

class InventoryLogService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  InventoryLogService(){
    _http = getIt.get<HTTPService>();
  }

  Future<List<InventoryLogHistoryModel>> history({ required String startDate, required String endDate }) async {
    Response? _response = await _http?.get("/inventory-log/history", query: {
      "start_date": startDate,
      "end_date": endDate
    });
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<InventoryLogHistoryModel> _logs = _data['data'].map<InventoryLogHistoryModel>((_log){
        return InventoryLogHistoryModel.fromJson(_log);
      }).toList();
      return _logs;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<InventoryLogDetailModel> detail({ required int id }) async {
    Response? _response = await _http?.get("/inventory-log/detail/$id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      InventoryLogDetailModel _log = InventoryLogDetailModel.fromJson(_data['data']);
      return _log;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<InventoryLogDetailModel> create({ required int type, required List<InventoryCreateStockModel> stocks, String note = '' }) async {
    Response? _response = await _http?.post("/inventory-log", query: {
      "type": type,
      "note": note,
      "inventory_stocks": stocks.map((_stock) => _stock.toJson()).toList()
    });
    if(_response?.statusCode == 201){
      Map _data = _response?.data;
      InventoryLogDetailModel _log = InventoryLogDetailModel.fromJson(_data['data']);
      return _log;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }
}