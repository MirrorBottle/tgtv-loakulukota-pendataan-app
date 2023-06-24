import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/verification_data.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'http_service.dart';

class VerificationService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  VerificationService(){
    _http = getIt.get<HTTPService>();
  }

  Future<List<VerificationListModel>> list() async {
    Response? _response = await _http?.get("/inventory-validation");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      List<VerificationListModel> _verifications = _data['data'].map<VerificationListModel>((_verification){
        return VerificationListModel.fromJson(_verification);
      }).toList();
      return _verifications;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<VerificationDetailModel> detail({ required int id }) async {
    Response? _response = await _http?.get("/inventory-validation/$id");
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      VerificationDetailModel _verification = VerificationDetailModel.fromJson(_data['data']);
      return _verification;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<VerificationDetailModel> verified({ required int id, required String status, String note='' }) async {
    Response? _response = await _http?.post("/inventory-validation/verified/$id/$status", query: {
      'note': note
    });
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      VerificationDetailModel _verification = VerificationDetailModel.fromJson(_data['data']);
      return _verification;
    }else{
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<void> verifiedAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
    int _id = _auth['id'];
    await _http?.post("/inventory-validation/verified-all/$_id");
  }

}