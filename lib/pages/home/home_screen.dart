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

class AnnouncementCard extends StatelessWidget {
  final String announcement;
  const AnnouncementCard({required Key key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: context.width() - 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            announcement,
                            style: kTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          Expanded(
                              child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dapibus consequat odio, in tincidunt libero egestas at. Sed et condimentum enim. Proin dignissim nulla sit amet iaculis tempor. ",
                                  overflow: TextOverflow.fade,
                                  style: kTextStyle.copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13))),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTileItem {
  final String title;
  final String svg;
  String redirect;
  bool isEmptyTile;
  HomeTileItem(
      {required this.title,
      required this.svg,
      this.redirect = "-",
      this.isEmptyTile = false});
}

class HomeTileCard extends StatelessWidget {
  final HomeTileItem item;
  const HomeTileCard({required Key key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.isEmptyTile == false
        ? (Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                clipBehavior: Clip.antiAlias,
                elevation: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                          left: 22, right: 22, bottom: 15, top: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          left: BorderSide(
                            color: constPrimaryColor,
                            width: 5.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10), // radius of 10
                                color:
                                    constSecondaryColor // green as background color
                                ),
                            child: SvgPicture.asset(
                              'assets/svg/${item.svg}.svg',
                              width: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(item.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 58, 58, 58)))
                        ],
                      )),
                ),
              ),
            ),
          ))
        : (const Expanded(
            child: Padding(padding: EdgeInsets.all(4)),
          ));
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
  final List<String> announcements = [
    "Pengumuman 1",
    "Pengumuman 2",
    "Pengumuman 3"
  ];

  final List<List<HomeTileItem>> _timesRow = [
    [
      HomeTileItem(title: "Tambah Kelahiran", svg: "child"),
      HomeTileItem(title: "Tambah Pendatang", svg: "family"),
    ],
    [
      HomeTileItem(title: "Tambah Pindah", svg: "moving"),
      HomeTileItem(title: "Tambah Kematian", svg: "tombstone"),
    ],
    [
      HomeTileItem(title: "Download Laporan", svg: "download"),
      HomeTileItem(
          title: "Tambah Kematian", svg: "tombstone", isEmptyTile: true),
    ]
  ];

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
        title: Padding(
            padding: const EdgeInsets.only(left: 20, top: 40, bottom: 40),
            child: Text(
              "Selamat Datang! \n${_auth['name']}",
              maxLines: 2,
              style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
            )),
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
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...announcements
                        .map<Widget>((announcement) => AnnouncementCard(
                            key: ObjectKey(announcement),
                            announcement: announcement))
                        .toList(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.antiAlias,
                        color: constSecondaryColor,
                        child: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: context.width() - 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/megaphone.svg',
                                        width: 40,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text("Lihat Semua Pengumuman")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(minHeight: context.height() - 300),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Color.fromARGB(255, 250, 250, 250),
                ),
                child: Column(
                  children: [
                    if (_auth['role'] == 'admin') ...[],
                    const SizedBox(
                      height: 25.0,
                    ),
                    ..._timesRow.map<Widget>((_tileRow) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ..._tileRow
                                .map<Widget>((_tile) => HomeTileCard(
                                    key: ObjectKey(_tile), item: _tile))
                                .toList(),
                          ],
                        ))
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
