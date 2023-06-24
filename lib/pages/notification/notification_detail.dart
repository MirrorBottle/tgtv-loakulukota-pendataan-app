import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/models/notification_data.dart';
import 'package:loakulukota_app/services/notification_service.dart';

class NotificationDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const NotificationDetailScreen({this.args, Key? key}) : super(key: key);

  @override
  _NotificationDetailScreenState createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  
  final NotificationService _notificationService = NotificationService();
  NotificationListModel? _notification;
  
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    EasyLoading.show(status: 'Mohon Ditunggu', maskType: EasyLoadingMaskType.black);
    NotificationListModel _notificationData = await _notificationService.detail(id: widget.args!['id']);
    setState(() {
      _notification = _notificationData;
    });
    if(!_notificationData.isRead) {
      await _notificationService.read(id: widget.args!['id']);
    }
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
              'Isi Pesan',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Chip(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: constPrimaryColor,
                          shadowColor: Colors.black, //CircleAvatar
                          label: Text(
                            _notification != null ? _notification!.datetime : '-',
                            style: const TextStyle(color: Colors.white),
                          ), //Text
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _notification != null ? _notification!.title : '-',
                          style: constHeadingStyle.copyWith(
                            fontSize: 19
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _notification != null ? _notification!.message : '-',
                          style: constSubStyle.copyWith(
                            fontSize: 15
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    ButtonGlobal(
                      buttontext: 'Kembali',
                      buttonDecoration:
                          constButtonDecoration.copyWith(color: constPrimaryColor),
                      onPressed: () => Navigator.of(context).pop(),
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
