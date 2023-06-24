import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/services/dashboard_service.dart';
import 'package:loakulukota_app/models/dashboard_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

class DashboardShortageTile extends StatelessWidget {
  final DashboardShortageModel shortage;
  const DashboardShortageTile({required Key key, required this.shortage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          minLeadingWidth: 30,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning, size: 20.0, color: constPrimaryColor)
            ],
          ),
          title: Text("${shortage.code} - ${shortage.name}",
              style: const TextStyle(color: Colors.black)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Tersisa: ${shortage.quantity} ${shortage.unit}")],
          ),
        )
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _auth = {};
  final DashboardService _dashboardService = DashboardService();
  DashboardModel? _dashboard;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // EasyLoading.show(
    //     status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String encodedAuth = prefs.getString('auth') ?? "{}";

    // DashboardModel _dashboardData = await _dashboardService.index();
    // setState(() {
    //   _auth = json.decode(encodedAuth);
    //   _dashboard = _dashboardData;
    // });
    // EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    DashboardModel _dashboardData = await _dashboardService.index();
    setState(() {
      _dashboard = _dashboardData;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(minHeight: context.height() - 80),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang! \n${_auth['name']}",
                          maxLines: 2,
                          style: kTextStyle.copyWith(
                              color: constPrimaryColor, fontSize: 20.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (_auth['role'] == 'admin') ...[
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.antiAlias,
                        elevation: 4.5,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, "inventory-create-in"),
                          child: Container(
                            width: context.width() - 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                left: BorderSide(
                                  color: constSuccessColor,
                                  width: 5.0,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.all(23),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.move_to_inbox,
                                              size: 50,
                                              color: constSuccessColor),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Tambah Barang Masuk",
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "Terakhir: ${_dashboard != null ? _dashboard!.inventoryIn : '-'}",
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 4.5,
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, "inventory-create-out"),
                        child: Container(
                          width: context.width() - 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              left: BorderSide(
                                color: constDangerColor,
                                width: 5.0,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(23),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.outbox,
                                            size: 50, color: constDangerColor),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tambah Barang Keluar",
                                              style: kTextStyle.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 5),
                                            if (_auth['role'] == 'admin') ...[
                                              Text(
                                                "Terakhir: ${_dashboard != null ? _dashboard!.inventoryOut : '-'}",
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    if (_auth['role'] == 'admin') ...[
                      if (_dashboard != null &&
                          _dashboard!.shortages.isNotEmpty) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stok Item Kurang',
                              style: kTextStyle.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        ..._dashboard!.shortages
                            .map<Widget>((shortage) => DashboardShortageTile(
                                key: ObjectKey(shortage), shortage: shortage))
                            .toList()
                      ] else ...[
                        const SizedBox(
                          height: 40.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/no-shortage.svg',
                              width: 200,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Kondisi stok terpenuhi!",
                              style: constHeadingStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
