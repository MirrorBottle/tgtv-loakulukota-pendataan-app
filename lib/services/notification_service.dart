import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/notification_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'http_service.dart';

class NotificationService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  NotificationService(){
    _http = getIt.get<HTTPService>();
  }

  Future<List<NotificationListModel>> list() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
    int _id = _auth['id'];
    Response? _response = await _http?.get("/notification/list/$_id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<NotificationListModel> _notifications = _data['data'].map<NotificationListModel>((_notification){
        return NotificationListModel.fromJson(_notification);
      }).toList();
      return _notifications;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<NotificationListModel> detail({ required int id }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? _response = await _http?.get("/notification/detail/$id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      NotificationListModel _notification = NotificationListModel.fromJson(_data['data']);
      return _notification;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<NotificationListModel> read({ required int id }) async {
    Response? _response = await _http?.post("/notification/read/$id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      NotificationListModel _notification = NotificationListModel.fromJson(_data['data']);
      return _notification;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
    int _id = _auth['id'];
    await _http?.post("/notification/delete-all/$_id");
  }

}