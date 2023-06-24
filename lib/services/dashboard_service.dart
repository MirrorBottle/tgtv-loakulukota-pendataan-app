import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/dashboard_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'http_service.dart';

class DashboardService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  DashboardService(){
    _http = getIt.get<HTTPService>();
  }

  Future<DashboardModel> index() async {
    Response? _response = await _http?.get("/inventory-dashboard");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      DashboardModel _dashboard = DashboardModel.fromJson(_data['data']);
      return _dashboard;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

}