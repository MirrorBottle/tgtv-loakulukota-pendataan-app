import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:loakulukota_app/models/auth.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:loakulukota_app/services/http_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/globals.dart';
import 'dart:convert';
import 'http_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;

class AuthService {
  final GetIt getIt = GetIt.instance;

  HTTPService? _http;

  AuthService(){
    _http = getIt.get<HTTPService>();
  }

  Future<void> login({required String username, required String password, required String token}) async{
    Response? _response = await _http?.post('/auth/login', query: {
      'username' : username,
      'password' : password,
      'token': token
    });
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      Auth _login = Auth.fromJson(_data['data']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _authData = json.encode(_login.toMap());
      prefs.setString('auth', _authData);
      const MainScreen().launch(navigatorKey.currentState!.overlay!.context);
    } else {
      awesome_dialog.AwesomeDialog(
        context: navigatorKey.currentState!.overlay!.context,
        animType: awesome_dialog.AnimType.BOTTOMSLIDE,
        headerAnimationLoop: false,
        dialogType: awesome_dialog.DialogType.ERROR,
        showCloseIcon: true,
        title: 'Gagal Login!',
        desc: 'Password atau username anda salah!',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle
      ).show();
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<Auth> relog({required String password}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
    String _username = _auth['username'];
    Response? _response = await _http?.post('/auth/login', query: {
      'username' : _username,
      'password' : password,
      'token': '',
      'relog': true
    });
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      Auth _login = Auth.fromJson(_data['data']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _authData = json.encode(_login.toMap());
      prefs.setString('auth', _authData);
      return _login;
    } else {
      const SnackBar snackBar = SnackBar(content: Text("Gagal masuk, pastikan password dan username terdaftar"), backgroundColor: Colors.redAccent, duration: Duration(seconds: 3));
      snackbarKey.currentState?.showSnackBar(snackBar); 
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<void> changePassword({required String oldPassword, required String newPassword}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> _auth = json.decode(prefs.getString('auth') ?? "{}");
    int _id = _auth['id'];
    Response? _response = await _http?.post('/auth/change-password/$_id', query: {
      'oldPassword' : oldPassword,
      'newPassword' : newPassword,
    });
    _response.toString();
    if(_response?.statusCode == 200){
      const SnackBar snackBar = SnackBar(content: Text("Berhasil mengubah password!"), backgroundColor: Colors.green, duration: Duration(seconds: 3));
      snackbarKey.currentState?.showSnackBar(snackBar); 
    } else {
      const SnackBar snackBar = SnackBar(content: Text("Gagal mengubah password!"), backgroundColor: Colors.redAccent, duration: Duration(seconds: 3));
      snackbarKey.currentState?.showSnackBar(snackBar); 
      throw Exception('Couldn\'t access auth.');
    }
  }

  Future<Map<dynamic, dynamic>> maintenance() async{
    Response? _response = await _http?.get('/auth/maintenance');
    _response.toString();
    if(_response?.statusCode == 200){
      Map _data = _response?.data;
      return _data['data']; 
    } else {
      const SnackBar snackBar = SnackBar(content: Text("Gagal mengubah password!"), backgroundColor: Colors.redAccent, duration: Duration(seconds: 3));
      snackbarKey.currentState?.showSnackBar(snackBar); 
      throw Exception('Couldn\'t access auth.');
    }
  }

}