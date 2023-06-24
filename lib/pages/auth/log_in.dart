import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/models/auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final AuthService _authService = AuthService();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onPressedLogin() async {
    if (_password.text.isNotEmpty) {
      const MainScreen().launch(context);
      // EasyLoading.show(
      //     status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
      // _authService
      //     .relog(password: _password.text)
      //     .then((Auth auth) => const MainScreen().launch(context))
      //     .whenComplete(() {
      //   EasyLoading.dismiss();
      // });
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
            'Masuk Kembali',
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
            padding: const EdgeInsets.only(left: 20.0, bottom: 30.0, top: 10.0),
            child: Text(
              'Setiap kali anda menutup aplikasi, password akan kembali diminta',
              style: GoogleFonts.manrope(color: Colors.white, fontSize: 13.0),
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
                  AppTextField(
                    controller: _password,
                    autoFocus: true,
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
                    buttonDecoration:
                        constButtonDecoration.copyWith(color: constPrimaryColor),
                    onPressed: _onPressedLogin,
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
