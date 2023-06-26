import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/models/announcement_data.dart';
import 'package:loakulukota_app/services/announcement_service.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'dart:convert';

class AnnouncementDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const AnnouncementDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _AnnouncementDetailScreenState createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  final AnnouncementService _announcementService = AnnouncementService();
  AnnouncementModel? _announcement;
  
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(
        status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    AnnouncementModel _announcementData =
        await _announcementService.detail(id: widget.args!['id']);
    setState(() {
      _announcement = _announcementData;
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
              'Detail Pengumuman',
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          if (_announcement != null) ... [
                            Text(
                              _announcement!.title,
                              textAlign: TextAlign.left,
                              style: constListTitleStyle.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Tanggal Kegiatan: ${_announcement!.activityDate}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 20),

                            Text(
                              _announcement!.content,
                              textAlign: TextAlign.left,
                            ),
                          ]
                        ],
                      )
                    ),
                    
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
