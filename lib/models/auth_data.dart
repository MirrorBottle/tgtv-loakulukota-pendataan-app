import 'package:loakulukota_app/models/auth.dart';

class AuthData {
  final int? status;
  final String? message;
  final Auth? data;
  
  AuthData({this.status, this.message, required this.data});
  //
  // AuthData.initial()
  //     : data ,
  //       status = 1,
  //       message = '';

  AuthData copyWith({required Auth data, int? status, String? message}) {
    return AuthData(data: data, message: message, status: status);
    // return AuthData(movies: movies ?? this.movies,
    //     page: page ?? this.page,
    //     searchCategory: searchCategory ?? this.searchCategory,
    //     searchText: searchText ?? this.searchText);
  }

}
