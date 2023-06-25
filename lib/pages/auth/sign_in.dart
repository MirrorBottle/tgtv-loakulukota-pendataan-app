import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/notification.dart';
import 'package:loakulukota_app/models/auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.dismiss();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth');
  }

  Future<void> _onPressedLogin() async {
    String _token = "";
    // !! TOKEN (REMOVE ON USING WINDOWS)
    if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
      if (defaultTargetPlatform != TargetPlatform.windows) {
        final firebaseMessaging = FCM();
        firebaseMessaging.setNotifications();
        _token = await firebaseMessaging.getToken();
      }
      EasyLoading.show(
          status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
      _authService
          .login(
              username: _username.text, password: _password.text, token: _token)
          .whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: constPrimaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: constPrimaryColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 5),
            child: Text(
              'Masuk',
              style: kTextStyle.copyWith(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, bottom: 30.0, top: 10.0),
              child: Text(
                'Gunakan username yang sudah diberikan.',
                style: GoogleFonts.manrope(color: Colors.white, fontSize: 14.0),
                // style: kTextStyle.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 60.0,
                      child: AppTextField(
                        textFieldType: TextFieldType.USERNAME,
                        controller: _username,
                        enabled: true,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: kTextStyle,
                          hintText: 'Masukkan username',
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kBorderColorTextField),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      controller: _password,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        floatingLabelStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        labelStyle: kTextStyle,
                        hintText: 'Masukkan password',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kBorderColorTextField),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ButtonGlobal(
                      buttontext: 'Masuk',
                      buttonDecoration: constButtonDecoration.copyWith(
                          color: constPrimaryColor),

                      // onPressed: _onPressedFunction,
                      onPressed: () async {
                        _onPressedLogin();
                      },
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
