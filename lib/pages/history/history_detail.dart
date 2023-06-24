import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/inventory_log_data.dart';
import 'package:loakulukota_app/services/inventory_log_service.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HistoryDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const HistoryDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _HistoryDetailScreenState createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final InventoryLogService _logService = InventoryLogService();
  InventoryLogDetailModel? _log;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    InventoryLogDetailModel _logData =
        await _logService.detail(id: widget.args!['id']);
    setState(() {
      _log = _logData;
    });
    EasyLoading.dismiss();
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
                'Detail Histori',
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
                    if (_log != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            _log!.code,
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
                                  "Detail Data",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ListTile(
                                  leading: const Text("Tipe"),
                                  trailing: Chip(
                                    padding: const EdgeInsets.all(8),
                                    backgroundColor: _log!.type == "1"
                                        ? constPrimaryColor
                                        : constSuccessColor,
                                    shadowColor: Colors.black, //CircleAvatar
                                    label: Text(
                                      _log!.type == "1"
                                          ? "Barang Keluar"
                                          : "Barang Masuk",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ), //Text
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Tanggal"),
                                  trailing: Text(_log!.date),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: const Text("Pengguna"),
                                  trailing: Text(_log!.userName),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                const ListTile(
                                  leading: Text("Catatan"),
                                  contentPadding: EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: Text(_log!.note),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                                if (_log!.type == "1") ...[
                                  ListTile(
                                    leading: const Text("Tgl. Validasi"),
                                    trailing: Text(_log!.validatedAt),
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                  ),
                                  ListTile(
                                    leading: const Text("Divalidasi Oleh"),
                                    trailing: Text(_log!.adminName),
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                  ),
                                  const ListTile(
                                    leading: Text("Catatan Validasi"),
                                    contentPadding: EdgeInsets.all(0),
                                    dense: true,
                                  ),
                                  ListTile(
                                    leading: Text(_log!.validationNote),
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                  ),
                                ],
                                const SizedBox(height: 30),
                                Text(
                                  "Daftar Barang",
                                  textAlign: TextAlign.left,
                                  style: constListTitleStyle,
                                ),
                                const SizedBox(height: 10),
                                ..._log!.stocks
                                    .map<Widget>((_stock) => ListTile(
                                          leading: Text(
                                              "(${_stock.code}) ${_stock.name}"),
                                          trailing: Text(
                                              "${_stock.quantity} ${_stock.unit}"),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                        ))
                                    .toList()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                    ButtonGlobal(
                      buttontext: 'Kembali',
                      buttonDecoration: constButtonDecoration.copyWith(
                          color: constPrimaryColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
