import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/announcement_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'http_service.dart';

class AnnouncementService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  AnnouncementService(){
    _http = getIt.get<HTTPService>();
  }

  Future<List<AnnouncementModel>> latest() async {
    Response? _response = await _http?.get("/announcement/latest");
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<AnnouncementModel> _items = _data['data'].map<AnnouncementModel>((_item){
        return AnnouncementModel.fromJson(_item);
      }).toList();
      return _items;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<List<AnnouncementModel>> list({ String keyword='', int page=1, int limit=10 }) async {
    Response? _response = await _http?.get("/announcement", query: {
      "keyword": keyword,
      "page": page,
      "limit": limit,
    });
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<AnnouncementModel> _items = _data['data'].map<AnnouncementModel>((_item){
        return AnnouncementModel.fromJson(_item);
      }).toList();
      return _items;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

}