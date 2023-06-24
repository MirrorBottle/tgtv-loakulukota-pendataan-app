import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:loakulukota_app/pages/verification/verification_list.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/verification_data.dart';
import 'package:loakulukota_app/services/verification_service.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class VerificationDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const VerificationDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _VerificationDetailScreenState createState() =>
      _VerificationDetailScreenState();
}

class _VerificationDetailScreenState extends State<VerificationDetailScreen> {
  final VerificationService _verificationService = VerificationService();
  VerificationDetailModel? _verification;
  final _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    VerificationDetailModel _verificationData =
        await _verificationService.detail(id: widget.args!['id']);
    setState(() {
      _verification = _verificationData;
    });
    EasyLoading.dismiss();
  }

  Future<void> _onVerifiedPressed(String status) async {
    awesome_dialog.AwesomeDialog(
            context: context,
            dialogType: awesome_dialog.DialogType.WARNING,
            animType: awesome_dialog.AnimType.BOTTOMSLIDE,
            title: 'Apakah anda yakin?',
            desc: 'Barang keluar akan tervalidasi!',
            btnOkText: "Ya",
            btnOkOnPress: () async {
              EasyLoading.show(
                  status: 'Mohon Ditunggu',
                  maskType: EasyLoadingMaskType.black);
              await _verificationService.verified(
                  id: widget.args!['id'], status: status, note: _note.text);
              EasyLoading.dismiss();
              awesome_dialog.AwesomeDialog(
                      context: context,
                      animType: awesome_dialog.AnimType.BOTTOMSLIDE,
                      headerAnimationLoop: false,
                      dialogType: awesome_dialog.DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Berhasil',
                      desc: 'Berhasil Verifikasi Barang Keluar!',
                      btnOkOnPress: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainScreen()),
                            (Route route) => false);
                      },
                      onDissmissCallback: (type) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainScreen()),
                            (Route route) => false);
                      },
                      btnOkIcon: Icons.check_circle)
                  .show();
            },
            btnCancelText: "Tidak",
            btnCancelOnPress: () {})
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                'Validasi Barang Keluar',
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
                constraints: BoxConstraints(minHeight: context.height() - 80),
                width: context.width(),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_verification != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            _verification!.code,
                            style: constHeadingStyle.copyWith(fontSize: 19),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: context.width(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Info Barang Keluar",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  leading: const Text("Tanggal"),
                                  trailing: Text(_verification!.date),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Pengguna"),
                                  trailing: Text(_verification!.userName),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  "Daftar Barang",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ..._verification!.stocks
                                    .map<Widget>((_stock) => ListTile(
                                          leading: Text(
                                              "(${_stock.code}) ${_stock.name}"),
                                          trailing: Text(
                                              "${_stock.quantity} ${_stock.unit}"),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                        ))
                                    .toList(),
                                const SizedBox(height: 30),
                                Text(
                                  "Catatan",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                AppTextField(
                                  controller: _note,
                                  textFieldType: TextFieldType.MULTILINE,
                                  minLines: 4,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    labelStyle: kTextStyle,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kBorderColorTextField),
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                    Column(
                      children: [
                        ButtonGlobal(
                          buttontext: 'Tolak',
                          buttonDecoration: constButtonDecoration.copyWith(
                              color: constPrimaryColor),
                          onPressed: () => _onVerifiedPressed("2"),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ButtonGlobal(
                          buttontext: 'Terima',
                          buttonDecoration: constButtonDecoration.copyWith(
                              color: constSuccessColor),
                          onPressed: () => _onVerifiedPressed("3"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
