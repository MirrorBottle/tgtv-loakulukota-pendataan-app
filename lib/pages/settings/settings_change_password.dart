import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
class SettingsChangePasswordScreen extends StatefulWidget {
  const SettingsChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _SettingsChangePasswordScreenState createState() => _SettingsChangePasswordScreenState();
}

class _SettingsChangePasswordScreenState extends State<SettingsChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        AuthService _authService = AuthService();
        final _oldPassword = TextEditingController();
        final _newPassword = TextEditingController();
        final _newPasswordConfirm = TextEditingController();

        Future<void> _onPressedLogin() async {
          if(_oldPassword.text.isEmpty || _newPassword.text.isEmpty || _oldPassword.text.isEmpty) {
            awesome_dialog.AwesomeDialog(
              context: context,
              dialogType: awesome_dialog.DialogType.ERROR,
              animType: awesome_dialog.AnimType.BOTTOMSLIDE,
              headerAnimationLoop: true,
              title: 'Gagal!',
              desc: 'Pastikan semua sudah terisi!',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red,
            ).show();
            return;
          }
          if(_newPassword.text != _newPasswordConfirm.text) {
            awesome_dialog.AwesomeDialog(
              context: context,
              dialogType: awesome_dialog.DialogType.ERROR,
              animType: awesome_dialog.AnimType.BOTTOMSLIDE,
              headerAnimationLoop: true,
              title: 'Password baru tidak cocok!',
              desc: 'Password dan konfirmasi password tidak cocok!',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red,
            ).show();
            return;
          }
          EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
          await _authService.changePassword(oldPassword: _oldPassword.text, newPassword: _newPassword.text);
          
          _oldPassword.clear();
          _newPassword.clear();
          _newPasswordConfirm.clear();
          EasyLoading.dismiss();
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: constPrimaryColor,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: constPrimaryColor,
            elevation: 0.0,
            titleSpacing: 0.0,
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50.0, bottom: 25),
              child: Text(
                'Ubah Password',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: BackButton(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: context.height() - 80
                  ),
                  width: context.width(),
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
                        textFieldType: TextFieldType.PASSWORD,
                        controller: _oldPassword,
                        enabled: true,
                        decoration: InputDecoration(
                          labelText: 'Password Lama',
                          labelStyle: kTextStyle,
                          hintText: 'Masukkan password lama',
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderColorTextField),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: _newPassword,
                        enabled: true,
                        decoration: InputDecoration(
                          labelText: 'Password Baru',
                          labelStyle: kTextStyle,
                          hintText: 'Masukkan password baru',
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderColorTextField),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      AppTextField(
                        controller: _newPasswordConfirm,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: 'Konfirmasi Password Baru',
                          floatingLabelStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          labelStyle: kTextStyle,
                          hintText: 'Konfirmasi password baru',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderColorTextField),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong!';
                          } else if (value != _newPassword.text) {
                            return 'Password tidak sama!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ButtonGlobal(
                        buttontext: 'Ubah Password',
                        buttonDecoration:
                            constButtonDecoration.copyWith(color: constPrimaryColor),
                        onPressed: _onPressedLogin,
                      ),
                      // ),
                    ],
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }
}