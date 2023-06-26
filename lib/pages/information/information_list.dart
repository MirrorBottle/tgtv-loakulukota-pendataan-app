import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:loakulukota_app/models/information_data.dart';
import 'package:loakulukota_app/services/item_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
import 'package:flutter_svg/flutter_svg.dart';

class InformationListScreen extends StatefulWidget {
  const InformationListScreen({Key? key}) : super(key: key);

  @override
  _InformationListScreenState createState() => _InformationListScreenState();
}

class _InformationListScreenState extends State<InformationListScreen> {
  final List<InformationModel> _informations = [
    InformationModel(
        icon: "people",
        title: "Total Populasi",
        value: "236 Orang",
        redirect: "-"),
    InformationModel(
        icon: "family",
        title: "Total Keluarga",
        value: "15 Keluarga",
        redirect: "-"),
    InformationModel(
        icon: "man",
        title: "Penduduk Laki-laki",
        value: "100 Orang",
        redirect: "-"),
    InformationModel(
        icon: "arab-woman",
        title: "Penduduk Perempuan",
        value: "136 Orang",
        redirect: "-"),
    InformationModel(
        icon: "children",
        title: "Anak-anak di Bawah 6 Tahun",
        value: "10 Orang",
        redirect: "-"),
    InformationModel(
        icon: "child",
        title: "Kelahiran",
        value: "236 Anak",
        redirect: "-"),
    InformationModel(
        icon: "family",
        title: "Pendatang",
        value: "236 Orang",
        redirect: "-"),
    InformationModel(
        icon: "tombstone",
        title: "Kematian",
        value: "236 Orang",
        redirect: "-"),
    InformationModel(
        icon: "moving",
        title: "Pindah",
        value: "236 Orang",
        redirect: "-"),
  ];
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<InformationListModel> _itemsData = await _itemService.list();
    // setState(() {
    //   _items = _itemsData;
    // });
    // EasyLoading.dismiss();
  }

  Future<void> _refresh() async {
    // EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    // List<InformationListModel> _itemsData = await _itemService.list();
    // setState(() {
    //   _items = _itemsData;
    // });
    // EasyLoading.dismiss();
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
                'Informasi Penduduk',
                style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
              ),
            ),
            leading: const Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: BackButton(),
            ),
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
                      const SizedBox(height: 10),
                      ..._informations
                          .map<Widget>((_information) => ListTile(
                                onTap: () {},
                                minLeadingWidth: 20,
                                title: Text(_information.title,
                                    style: const TextStyle(color: Colors.black)),
                                leading: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10), // radius of 10
                                      color:
                                          constSecondaryColor // green as background color
                                      ),
                                  child: SvgPicture.asset(
                                    'assets/svg/${_information.icon}.svg',
                                    width: 38,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 2),
                                    Text(_information.value)
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
