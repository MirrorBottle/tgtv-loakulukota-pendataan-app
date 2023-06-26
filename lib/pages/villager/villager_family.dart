import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/models/villager_data.dart';
import 'package:loakulukota_app/services/villager_service.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'dart:convert';

class VillagerFamilyScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const VillagerFamilyScreen({this.args, Key? key}) : super(key: key);

  @override
  _VillagerFamilyScreenState createState() => _VillagerFamilyScreenState();
}

class _VillagerFamilyScreenState extends State<VillagerFamilyScreen> {
  final VillagerService _villagerService = VillagerService();
  VillagerDetailModel? _villager;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    VillagerDetailModel _villagerData =
        await _villagerService.detail(id: widget.args!['id']);
    setState(() {
      _villager = _villagerData;
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
                'Detail Penduduk',
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: context.width(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            if (_villager != null) ...[
                              Text(
                                _villager!.name,
                                style:
                                    constListTitleStyle.copyWith(fontSize: 22),
                              ),
                              Text(
                                _villager!.idNumber,
                                style: constSubStyle.copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                leading: const Text("No. KK"),
                                trailing: Text(_villager!.familyNumber),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Tempat, Tgl Lahir"),
                                trailing: Text("${_villager!.birthPlace}, ${_villager!.birthDate}", textAlign: TextAlign.right,),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Agama"),
                                trailing: Text(_villager!.religion),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Jenis Kelamin"),
                                trailing: Text(_villager!.gender),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Usia"),
                                trailing: Text("${_villager!.age} Thn."),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Status"),
                                trailing: Text(_villager!.maritalStatus),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Pend. Terakhir"),
                                trailing: Text(_villager!.education),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Nama Ortu Laki-laki"),
                                trailing: Text(_villager!.fatherName),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Nama Ortu Perempuan"),
                                trailing: Text(_villager!.motherName),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              ListTile(
                                leading: const Text("Pekerjaan"),
                                trailing: Text(_villager!.job),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                              ),
                              const ListTile(
                                  leading: Text("Alamat"),
                                  contentPadding: EdgeInsets.all(0),
                                  dense: true,
                                ),
                                ListTile(
                                  leading: Text(_villager!.address ?? "-"),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  clipBehavior: Clip.antiAlias,
                                  color: constSecondaryColor,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, "announcement-list"),
                                    child: SizedBox(
                                      width: context.width(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/family.svg',
                                                    width: 40,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  const Text(
                                                      "Lihat Anggota Keluarga")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ButtonGlobal(
                                buttontext: 'Kembali',
                                buttonDecoration: constButtonDecoration.copyWith(
                                    color: constPrimaryColor),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ]
                          ],
                        )),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
