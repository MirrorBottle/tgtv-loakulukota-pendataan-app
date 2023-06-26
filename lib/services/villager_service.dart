import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/models/villager_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'http_service.dart';
import 'dart:convert';


class VillagerService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  VillagerService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<VillagerListModel>> list(
      {String keyword = '',
      int page = 1,
      int limit = 10,
      List<dynamic> neighborhoodIds = const []}) async {

    List<dynamic> _cur_ids = neighborhoodIds;

    if(neighborhoodIds.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String encodedAuth = prefs.getString('auth') ?? "{}";
      Map<String, dynamic> _auth = json.decode(encodedAuth);
      _cur_ids = json.decode(_auth['neighborhoods']).map((_neighborhood) => _neighborhood['id']).toList();
    }
    Response? _response = await _http?.get("/villager", query: {
      "keyword": keyword,
      "page": page,
      "limit": limit,
      "neighborhood_ids": _cur_ids.join(",")
    });
    _response.toString();
    if (_response?.statusCode == 200) {
      Map _data = _response?.data;
      List<VillagerListModel> _items =
          _data['data'].map<VillagerListModel>((_item) {
        return VillagerListModel.fromJson(_item);
      }).toList();
      return _items;
    } else {
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<VillagerDetailModel> detail({required int id}) async {
    Response? _response = await _http?.get("/villager/$id");
    if (_response?.statusCode == 200) {
      Map _data = _response?.data;
      VillagerDetailModel _item = VillagerDetailModel.fromJson(_data['data']);
      return _item;
    } else {
      throw Exception('Couldn\'t access auth.');
    }
  }
}
