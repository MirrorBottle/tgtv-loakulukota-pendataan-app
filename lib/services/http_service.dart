import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../models/app_config.dart';
import 'package:loakulukota_app/globals.dart';
import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/pages/auth/sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String _baseURL = "";

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _baseURL = _config.BASE_API_URL;
  }

  Future<Response?> get(String _path, {Map<String, dynamic>? query}) async {
    try{
      String _url = '$_baseURL$_path';
      Map<String, dynamic> _query = {
        // 'params': 'param-value'
      };
      if(query!=null){
        _query.addAll(query);
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
      String _token = _auth['bearerToken'] ?? "";
      dio.options.headers["Authorization"] = "Bearer $_token";
      return await dio.get(_url, queryParameters: _query);
    }on DioError catch(e){
      SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan!"), duration: Duration(seconds: 3));
      snackbarKey.currentState?.showSnackBar(snackBar); 
      print("Unable to perform get request.");
      print("DioError:$e");
      navigatorKey.currentState!.pushNamed('sign-in');
    }
    return null;
  }

  Future<Response?> post(String _path, {Map<String, dynamic>? query}) async{
    try{
      String _url = '$_baseURL$_path';
      Map<String, dynamic> _query = {
        // 'params': 'param-value'
      };
      if(query!=null){
        _query.addAll(query);
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
      String _token = _auth['bearerToken'] ?? "";
      dio.options.headers["Authorization"] = "Bearer $_token";
      return await dio.post(_url, queryParameters: _query);

    } on DioError catch(e){
      if(_path != '/auth/login') {
        SnackBar snackBar = const SnackBar(content: Text("Terjadi kesalahan!"), duration: Duration(seconds: 3));
        snackbarKey.currentState?.showSnackBar(snackBar); 
        print("Unable to perform post request.");
        print("DioError:$e");
        navigatorKey.currentState!.pushNamedAndRemoveUntil('/sign-in', (Route route) => false);
      }
    }
    return null;
  }

}